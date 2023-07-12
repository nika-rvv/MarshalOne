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
    
    func getIndexesOfEmptyFields(email: String, password: String) -> [Int] {
        var result = [Int]()
        if email.isEmpty {
            result.append(0)
        }
        if password.isEmpty {
            result.append(1)
        }
        return result
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
    func didTapSignInButton(with email: String, and password: String) {
        let emptyFields = getIndexesOfEmptyFields(email: email, password: password)
        if emptyFields.isEmpty {
            interactor.enterButtonPressed(email: email, password: password)
        } else {
            view?.showEmptyFields(withIndexes: emptyFields)
        }
    }
    
    func didTapRegButton() {
        router.openRegScreen()
    }
    
    func isUserRemembered(isRemembered: Bool, forKey: String){
        interactor.rememberUser(isRemembered: isRemembered, key: forKey)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func authorized() {
        self.router.openMainFlow()
    }
    
    func notAuthorized(withReason reason: String) {
        view?.showNonAuthorized(with: reason)
    }
}
