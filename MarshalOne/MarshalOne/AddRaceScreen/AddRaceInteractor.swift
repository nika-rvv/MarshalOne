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
}

extension AddRaceInteractor: AddRaceInteractorInput {
    func addRace(with raceInfo: [String?]) {
        Task {
            let raceInfoStrings = raceInfo.compactMap{ $0 }
            
            let raceDate = DateClass(from: "2023-04-10T08:18:45.754Z", to: "2023-04-10T08:18:45.754Z")
            
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
        }
    }
}

