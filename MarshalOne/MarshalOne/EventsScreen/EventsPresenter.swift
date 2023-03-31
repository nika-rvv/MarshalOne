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
    func openEventScreen() {
        router.didtapEvent()
    }
    
    func didLoadRaces() {
        self.interactor.getRacesData()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func setRaces(races: RaceList) {
        view?.setData(raceData: races)
    }
}
