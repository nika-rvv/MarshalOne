//
//  EventPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import Foundation

final class EventPresenter {
	weak var view: EventViewInput?
    weak var moduleOutput: EventModuleOutput?
    
	private let router: EventRouterInput
	private let interactor: EventInteractorInput
    
    init(router: EventRouterInput, interactor: EventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventPresenter: EventModuleInput {
}

extension EventPresenter: EventViewOutput {
    func loadRaceInfo() {
        view?.showLoaderView()
        interactor.loadInfo()
    }
    
    func didPressBackButton() {
        router.backButtonTapped()
    }
    
    func postParticipant() {
        interactor.didPostParticipant()
    }
    
    func deleteParticipant() {
        interactor.didDeleteParticipant()
    }
}

extension EventPresenter: EventInteractorOutput {
    func setRace(races: OneEventInfo, isUnabledTobeMember: Bool) async {
        await MainActor.run {
            view?.hideLoaderView()
            view?.setData(raceData: races)
            view?.setMemberButton(isUnabledTobeMember: isUnabledTobeMember)
        }
    }
    
    func setMember() {
        view?.addMember()
    }
    
    func removeMember() {
        view?.deleteMember()
    }
}
