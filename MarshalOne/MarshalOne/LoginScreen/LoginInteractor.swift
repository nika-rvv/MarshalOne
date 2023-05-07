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
    
    private func setNotAuthorized(with reason: String) async {
        await MainActor.run {
            self.output?.notAuthorized(withReason: reason)
        }
    }
    
    private func setAutorized() async {
        await MainActor.run {
            self.output?.authorized()
        }
    }
}

extension LoginInteractor: LoginInteractorInput {
    func enterButtonPressed(email: String, password: String){
        Task {
            let authStatus = await userManager.login(email: email, password: password)
            switch authStatus {
            case .authorized:
                await setAutorized()
            case .nonAuthorized(error: let error):
                await setNotAuthorized(with: error)
            }
        }
    }
    
    func rememberUser(isRemembered: Bool, key: String) {
        defaults.set(isRemembered, forKey: key)
    }
}
