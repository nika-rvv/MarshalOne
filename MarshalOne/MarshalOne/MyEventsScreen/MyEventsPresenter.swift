//
//  MyEventsPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class MyEventsPresenter {
	weak var view: MyEventsViewInput?
    weak var moduleOutput: MyEventsModuleOutput?
    
	private let router: MyEventsRouterInput
	private let interactor: MyEventsInteractorInput
    
    init(router: MyEventsRouterInput, interactor: MyEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyEventsPresenter: MyEventsModuleInput {
}

extension MyEventsPresenter: MyEventsViewOutput {
}

extension MyEventsPresenter: MyEventsInteractorOutput {
}
