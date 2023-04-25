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
    // TODO: Remake
    func updateRaces(with raceInfo: [RaceListElement]?) async {
        if let raceInfo = raceInfo {
            await MainActor.run {
                self.output?.setRaces(races: raceInfo)
            }
        }
    }
    
}

extension EventsInteractor: EventsInteractorInput {    
    
    //TODO: LikeManager
    func setDislike(for raceId: Int) {
        Task {
            //            let error = await racesManager.deleteLike(with: raceId)
            //
            //            if error == nil {
            //                await MainActor.run{
            //                    self.output?.setDislike(raceId: raceId)
            //                }
            //            }
        }
    }
    
    func setLike(for raceId: Int) {
        //        Task {
        //            let error = await racesManager.postLike(with: raceId)
        //
        //            if error == nil {
        //                await MainActor.run{
        //                    self.output?.setLike(raceId: raceId)
        //                }
        //            }
    }
    
    ////
    
    //TODO: Убрать
    func updateRaceAtIndex(for raceId: Int) {
        //        Task {
        //            let error = await racesManager.putRace(with: raceId)
        //
        //            if error == nil {
        //                await MainActor.run{
        //                    self.output?.updateRace(raceId: raceId)
        //                }
        //            }
        //        }
    }
    // TODO: Вынести в менеджер
    func setView(for raceId: Int) {
        Task {
            //            let error = await racesManager.postView(with: raceId)
            //
            //            if error == nil {
            //                await MainActor.run{
            //                    self.output?.setViews(raceId: raceId)
            //                    print(raceId)
            //                }
            //            }
        }
    }
    
    func getRacesData() {
        Task {
            //            let racesInfo = await racesManager.getListOfRaces()
            //            if racesInfo.error != nil {
            //                print(racesInfo.error)
            //            } else {
            //                guard let info  = racesInfo.races else {
            //                    return
            //                }
            //                if (info.isEmpty) {
            //                    print("racesInfo is nil")
            //                } else {
            //                    await updateRaces(with: racesInfo.races)
            //                }
            //            }
        }
    }
}
    
