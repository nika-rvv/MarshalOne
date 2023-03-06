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
    func didPressBackButton() {
        router.backButtonTapped()
    }
}

extension EventPresenter: EventInteractorOutput {
}
