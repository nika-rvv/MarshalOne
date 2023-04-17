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
    func setDislike(for raceId: Int) {
        Task {
            await racesManager.deleteLike(with: raceId)
        }
        
        self.output?.setDislike(raceId: raceId)
    }
    
    func setLike(for raceId: Int) {
        Task {
            await racesManager.postLike(with: raceId)
        }
        
        self.output?.setLike(raceId: raceId)
    }
    
    func updateRaceAtIndex(for raceId: Int) {
        Task {
            await racesManager.putRace(with: raceId)
        }
        
        self.output?.updateRace(raceId: raceId)
    }
    
    func setView(for raceId: Int) {
        Task {
            await racesManager.postView(with: raceId)
        }
        
        self.output?.setViews(raceId: raceId)
        
        print(raceId)
    }
    
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
