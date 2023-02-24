//
//  RegisterPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?
    weak var moduleOutput: RegisterModuleOutput?
    
	private let router: RegisterRouterInput
	private let interactor: RegisterInteractorInput
    
    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterModuleInput {
}

extension RegisterPresenter: RegisterViewOutput {
    func didTapEnterButton() {
        router.openMainFlow()
    }
    
    func backButtonAction() {
        router.backButtonTapped()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
}
