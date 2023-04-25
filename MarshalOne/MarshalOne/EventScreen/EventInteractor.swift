//
//  EventInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import Foundation

final class EventInteractor {
	weak var output: EventInteractorOutput?
    
    private let raceManager: RacesNetworkManager
    private let raceId: Int
    
    init(raceManager: RacesNetworkManager, raceId: Int) {
        self.raceManager = raceManager
        self.raceId = raceId
    }
}

extension EventInteractor: EventInteractorInput {
    func loadInfo() {
        Task {
            let result = await raceManager.getRace(with: raceId)
            
            if let error = result.error {
                print(error)
            }
            
            if let race = result.race {
                self.output?.setRace(races: race)
            }
        }
    }
}
