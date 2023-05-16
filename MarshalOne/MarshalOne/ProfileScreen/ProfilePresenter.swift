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
        view?.showLoaderView()
        interactor.loadUserInfo()
    }
    
    func didChangeThemeViewTap() {
        router.didTapChangeTheme()
    }
    
    func didLogoutViewTap(){
        router.didTapLogout()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func setUserData(user: CurrentUser) {
        view?.hideLoaderView()
        self.view?.getData(userData: user)
    }
}
