//
//  AddRaceInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import Foundation

final class AddRaceInteractor {
    weak var output: AddRaceInteractorOutput?
    private let raceManager: RacesNetworkManager
    private let imageManager: ImageManager
    private let locationDecoder: LocationDecoder
    
    init(raceManager: RacesNetworkManager, locationDecoder: LocationDecoder, imageManager: ImageManager) {
        self.raceManager = raceManager
        self.locationDecoder = locationDecoder
        self.imageManager = imageManager
    }
    
    private func formatDate(dateFrom: String, dateTo: String) -> (String, String) {
//        var fromDateString = ""
//        var toDateString = ""
//
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert([.withFractionalSeconds,
                                        .withInternetDateTime])
        let dateStrFrom: [String] = dateFrom.components(separatedBy: ".")
        guard let convertedDateFrom = formatter.date(from: "\(dateStrFrom[2])-\(dateStrFrom[1])-\(dateStrFrom[0])T03:30:00.000Z") else {
            return ("", "")
        }
        
        let convertedDateFromStr = formatter.string(from: convertedDateFrom)
        
        let dateStrTo: [String] = dateTo.components(separatedBy: ".")
        guard let convertedDateTo = formatter.date(from: "\(dateStrTo[2])-\(dateStrTo[1])-\(dateStrTo[0])T03:30:00.000Z") else {
            return ("", "")
        }
        
        let convertedDateToStr = formatter.string(from: convertedDateTo)

        return (convertedDateFromStr, convertedDateToStr)
    }
    
    private func makeRaceInfo(raceInfo: [String?], imageId: Int) async -> AddRace {
        let raceInfoStrings = raceInfo.compactMap{ $0 }
        
        let date = formatDate(dateFrom: raceInfoStrings[1], dateTo: raceInfoStrings[2])
        
        let raceDate = DateClass(from: date.0, to: date.1)
        
        var location: Location = Location(latitude: 0.0, longitude: 0.0)
        
        do {
            location = try await locationDecoder.getLocation(from: raceInfoStrings[3])
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        let addRaceInfo = AddRace(name: raceInfoStrings[0],
                                  location: location,
                                  date: raceDate,
                                  oneRaceDescription: raceInfoStrings[4],
                                  images: ["/api/Image/\(imageId)"],
                                  tags: [])
        
        return addRaceInfo
    }
}

extension AddRaceInteractor: AddRaceInteractorInput {
    func addRace(with raceInfo: [String?], and imageData: Data?) {
        Task {
            var imageResult: (imageData: ImageData?, error: String?)? = nil
            if let image = imageData {
                imageResult = await imageManager.postImage(with: image)
            }
            
            if imageResult?.error != nil {
                print(imageResult?.error)
            } else {
                guard let imageId = imageResult?.imageData?.imageId else {
                    return
                }
                let postInfo = await makeRaceInfo(raceInfo: raceInfo, imageId: imageId)
                let postRaceResult = await raceManager.postRace(with: postInfo)
                if postRaceResult.error != nil {
                    print(postRaceResult.error)
                } else {
                    await MainActor.run {
                        output?.raceAdded()
                    }
                }
            }
            
        }
    }
    
    //    func addRace(with raceInfo: [String?]) {
    //        Task {
    //            let raceInfoStrings = raceInfo.compactMap{ $0 }
    //
    //            let date = formatDate(dateFrom: raceInfoStrings[1], dateTo: raceInfoStrings[2])
    //
    //            let raceDate = DateClass(from: date.0, to: date.1)
    //
    //            var location: Location = Location(latitude: 0.0, longitude: 0.0)
    //
    //            do {
    //                location = try await locationDecoder.getLocation(from: raceInfoStrings[3])
    //            } catch {
    //                print("Error: \(error.localizedDescription)")
    //            }
    //
    //            let addRaceInfo = AddRace(name: raceInfoStrings[0],
    //                                      location: location,
    //                                      date: raceDate,
    //                                      oneRaceDescription: raceInfoStrings[4],
    //                                      images: [],
    //                                      tags: [])
    //
    //            let addRaceResult = await raceManager.postRace(with: addRaceInfo)
    //
    //            await MainActor.run {
    //                output?.raceAdded()
    //            }
    //        }
    //    }
}

