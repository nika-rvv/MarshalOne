//
//  ProfileScreenInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class ProfileInteractor {
	weak var output: ProfileInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(userManager: UserNetworkManager) {
        self.userManager = userManager
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func loadUserInfo() {
        Task {
            let result = await userManager.currentUserInfo()
            if let error = result.error {
                print(error)
            }
            
            if let user = result.user {
                self.output?.setUserData(user: user)
            }
        }
    }
    
    func logoutUser() {
        self.userManager.logout()
    }
}
