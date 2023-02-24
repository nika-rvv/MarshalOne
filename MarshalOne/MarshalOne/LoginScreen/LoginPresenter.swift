//
//  LoginPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import Foundation

final class LoginPresenter {
    weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?
    
    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput
    
    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
    func didTapSignInButton() {
        router.openMainFlow()
    }
    
    func didTapRegButton() {
        router.openRegScreen()
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
