//
//  NewEventsPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import Foundation
import CoreLocation

final class NewEventsPresenter {
	weak var view: NewEventsViewInput?
    weak var moduleOutput: NewEventsModuleOutput?
    
	private let router: NewEventsRouterInput
	private let interactor: NewEventsInteractorInput
    
    init(router: NewEventsRouterInput, interactor: NewEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewEventsPresenter: NewEventsModuleInput {
}

extension NewEventsPresenter: NewEventsViewOutput {
    func didLoadRaces() {
        interactor.getRacesData()
    }
    
    func showLoader() {
        view?.showLoaderView()
    }
    
    func didOpenEvent(with index: Int) {
        let race = interactor.getEvent(by: index)
        router.selectedRowTapped(with: race.id)
        interactor.setWatcher(for: index)
    }
    
    func didSetLike(for raceId: Int) {
        interactor.setLike(for: raceId)
    }
    
    func didUnsetLike(for raceId: Int) {
        interactor.setDislike(for: raceId)
    }
}

extension NewEventsPresenter: NewEventsInteractorOutput {
    func showError(error: String?) {
        view?.showError(error: error)
        view?.hideLoaderView()
    }
    
    func setRaces(races: [RaceInfo]) {
        view?.update(withRaces: races)
        view?.hideLoaderView()
    }
    
    func setDislike(index: Int) {
        view?.setDislike(raceId: index)
        view?.hideLoaderView()
    }
    
    func setLike(index: Int) {
        view?.setLike(raceId: index)
        view?.hideLoaderView()
    }
    
    func setWatcher(index: Int) {
        view?.addWatcher(raceId: index)
        view?.hideLoaderView()
    }
}

