//
//  ProfileScreenPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class ProfilePresenter {
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func loadInfo() {
        interactor.loadUserInfo()
    }
    
    func didDeleteAcountViewTap() {
        router.didTapDeleteAcount()
    }
    
    func didLogoutViewTap(){
        router.didTapLogout()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func setUserData(user: CurrentUser) {
        DispatchQueue.main.async {
            self.view?.getData(userData: user)
        }
    }
}
