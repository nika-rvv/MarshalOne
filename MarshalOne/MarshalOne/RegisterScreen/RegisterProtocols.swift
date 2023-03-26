//
//  RegisterProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import Foundation

protocol RegisterModuleInput {
	var moduleOutput: RegisterModuleOutput? { get }
}

protocol RegisterModuleOutput: AnyObject {
}

protocol RegisterViewInput: AnyObject {
    func showEmptyFields(withIndexes indexes: [Int])
    func showCheckedPassword()
}

protocol RegisterViewOutput: AnyObject {
    func backButtonAction()
    func didTapEnterButton(regInfo: [String?])
}

protocol RegisterInteractorInput: AnyObject {
    func registerUser(with info: [String?])
}

protocol RegisterInteractorOutput: AnyObject {
    func authorized()
    func notAuthorized(withReason reason: String)
}

protocol RegisterRouterInput: AnyObject {
    func backButtonTapped()
    func openMainFlow()
}
