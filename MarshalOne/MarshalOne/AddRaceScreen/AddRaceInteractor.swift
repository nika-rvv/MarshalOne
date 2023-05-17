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
        guard let convertedDateFrom = formatter.date(from: "\(dateStrFrom[2])-\(dateStrFrom[1])-\(dateStrFrom[0])T13:06:38.991Z") else {
            return ("", "")
        }
        
        let convertedDateFromStr = formatter.string(from: convertedDateFrom)
        
        let dateStrTo: [String] = dateTo.components(separatedBy: ".")
        guard let convertedDateTo = formatter.date(from: "\(dateStrTo[2])-\(dateStrTo[1])-\(dateStrTo[0])T13:06:38.991Z") else {
            return ("", "")
        }
        
        let convertedDateToStr = formatter.string(from: convertedDateTo)
        
        return (convertedDateFromStr, convertedDateToStr)
    }
    
    private func makeRaceInfo(raceInfo: [String?], imageId: Int) async -> (race: AddRace?, error: String?)  {
        let raceInfoStrings = raceInfo.compactMap{ $0 }
        
        let date = formatDate(dateFrom: raceInfoStrings[1], dateTo: raceInfoStrings[2])
        
        let raceDate = DateClass(from: date.0, to: date.1)
        
        var location: Location = Location(latitude: 0.0, longitude: 0.0)
        
        do {
            location = try await locationDecoder.getLocation(from: raceInfoStrings[3])
        } catch {
            return (nil, "\(error)")
        }
        
        let addRaceInfo = AddRace(name: raceInfoStrings[0],
                                  location: location,
                                  date: raceDate,
                                  oneRaceDescription: raceInfoStrings[4],
                                  images: ["https://onwheels.enula.ru/api/Image/\(imageId)"],
                                  tags: [])
        
        return (addRaceInfo, nil)
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
                if let postInfoError = postInfo.error {
                    await MainActor.run {
                        output?.showEror(with: postInfoError)
                    }
                }
                
                var postRaceResult: (raceId: Int?, error: String?)
                
                if let postInfoRace = postInfo.race {
                    postRaceResult = await raceManager.postRace(with: postInfoRace)
                }
                if let postRaceResultError = postRaceResult.error {
                    await MainActor.run {
                        output?.showEror(with: postRaceResultError)
                    }
                } else {
                    await MainActor.run {
                        output?.raceAdded()
                    }
                }
            }
            
        }
    }
}

