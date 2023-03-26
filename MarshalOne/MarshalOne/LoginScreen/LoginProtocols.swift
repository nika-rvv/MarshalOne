//
//  LoginProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import Foundation

protocol LoginModuleInput {
	var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: AnyObject {
}

protocol LoginViewInput: AnyObject {
    func showEmptyFields(withIndexes indexes: [Int])
    func showNonAuthorized(with error: String)
}

protocol LoginViewOutput: AnyObject {
    func didTapRegButton()
    func didTapSignInButton(with email: String, and password: String)
}

protocol LoginInteractorInput: AnyObject {
    func enterButtonPressed(email: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func authorized()
    func notAuthorized(withReason reason: String)
}

protocol LoginRouterInput: AnyObject {
    func openRegScreen()
    func openMainFlow()
}
