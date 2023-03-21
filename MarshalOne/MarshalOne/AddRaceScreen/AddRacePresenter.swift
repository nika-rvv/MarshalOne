//
//  AddRacePresenter.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import Foundation

final class AddRacePresenter {
	weak var view: AddRaceViewInput?
    weak var moduleOutput: AddRaceModuleOutput?
    
	private let router: AddRaceRouterInput
	private let interactor: AddRaceInteractorInput
    
    init(router: AddRaceRouterInput, interactor: AddRaceInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AddRacePresenter: AddRaceModuleInput {
}

extension AddRacePresenter: AddRaceViewOutput {
    func didTapCloseViewControllerButton() {
        router.closeViewController()
    }
}

extension AddRacePresenter: AddRaceInteractorOutput {
}
