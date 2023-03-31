//
//  LoginInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(output: LoginInteractorOutput? = nil, userManager: UserNetworkManager) {
        self.output = output
        self.userManager = userManager
    }
}

extension LoginInteractor: LoginInteractorInput {
    func enterButtonPressed(email: String, password: String){
        Task {
            let authStatus = await userManager.login(email: email, password: password)
            switch authStatus {
            case .authorized:
                self.output?.authorized()
            case .nonAuthorized(error: let error):
                self.output?.notAuthorized(withReason: error)
            }
        }
    }
}
