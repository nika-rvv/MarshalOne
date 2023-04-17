//
//  EventsPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class EventsPresenter {
    weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    
    private let router: EventsRouterInput
    private let interactor: EventsInteractorInput
    
    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func openEvent(with index: Int) {
        router.selectedRowTapped(at: index)
        interactor.setView(for: index)
        interactor.updateRaceAtIndex(for: index)
    }
    
    func updateEvent(with index: Int) {
        interactor.updateRaceAtIndex(for: index)
    }
    
    func didSetLike(for raceId: Int) {
        interactor.setLike(for: raceId)
        interactor.updateRaceAtIndex(for: raceId)
    }
    
    func didUnsetLike(for raceId: Int) {
        interactor.setDislike(for: raceId)
        interactor.updateRaceAtIndex(for: raceId)
    }
    
    func didLoadRaces() {
        self.interactor.getRacesData()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func setDislike(raceId: Int) {
        view?.setLikeData(index: raceId)
        if userLiked.bool(forKey: "\(raceId)") {
            userLiked.set(false, forKey: "\(raceId)")
        }
    }
    
    func setViews(raceId: Int) {
        view?.setView(index: raceId)
    }
    
    func setLike(raceId: Int) {
        view?.setLikeData(index: raceId)
        if !userLiked.bool(forKey: "\(raceId)") {
            userLiked.set(true, forKey: "\(raceId)")
        }
        
    }
    

    
    func updateRace(raceId: Int) {
        view?.updateRace(raceId: raceId)
    }
    
    func setRaces(races: RaceList) {
        view?.setData(raceData: races)
    }
}
