//
//  EventsInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class EventsInteractor {
	weak var output: EventsInteractorOutput?
    private let racesManager: RacesNetworkManager
    
    init(racesManager: RacesNetworkManager) {
        self.racesManager = racesManager
    }
    
    func updateRaces(with raceInfo: [RaceListElement]?) async {
        if let raceInfo = raceInfo {
            await MainActor.run {
                self.output?.setRaces(races: raceInfo)
            }
        }
    }
    
}

extension EventsInteractor: EventsInteractorInput {
    func getRacesData() {
        Task {
            let racesInfo = await racesManager.getListOfRaces()
            if racesInfo.error != nil {
                print(racesInfo.error)
            } else {
                guard let info  = racesInfo.races else {
                    return
                }
                if (info.isEmpty) {
                    print("racesInfo is nil")
                } else {
                    await updateRaces(with: racesInfo.races)
                }
            }
        }
    }
}
