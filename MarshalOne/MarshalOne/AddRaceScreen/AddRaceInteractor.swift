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
    private let locationDecoder: LocationDecoder
    
    init(raceManager: RacesNetworkManager, locationDecoder: LocationDecoder) {
        self.raceManager = raceManager
        self.locationDecoder = locationDecoder
    }
    
    private func formatDate(dateFrom: String, dateTo: String) -> (String, String) {
        var fromDateString = ""
        var toDateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.eventCellDateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let dateFrom = inputFormatter.date(from: dateFrom) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            fromDateString = outputFormatter.string(from: dateFrom)
        } else {
            fromDateString = "Error"
        }
        
        if let dateTo = inputFormatter.date(from: dateTo) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            toDateString = outputFormatter.string(from: dateTo)
        }
        
        return (fromDateString, toDateString)
    }
}

extension AddRaceInteractor: AddRaceInteractorInput {
    func addRace(with raceInfo: [String?]) {
        Task {
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
                                      images: [],
                                      tags: [])
            
            let addRaceResult = await raceManager.postRace(with: addRaceInfo)
            
            await MainActor.run {
                output?.raceAdded()
            }
        }
    }
}

