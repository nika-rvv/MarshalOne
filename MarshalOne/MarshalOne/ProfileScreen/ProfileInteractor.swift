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
    
    private func setUserDataWithoutErrors(with data: CurrentUser) async {
        await MainActor.run {
            self.output?.setUserData(user: data)
        }
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func loadUserInfo() {
        Task {
            let result = await userManager.currentUserInfo()
            if let error = result.error {
                output?.showError(with: error)
            }
            if let user = result.user {
                await setUserDataWithoutErrors(with: user)
            }
        }
    }
    
    func logoutUser() {
        self.userManager.logout()
    }
}
