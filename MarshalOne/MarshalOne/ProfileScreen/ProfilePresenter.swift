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
}

extension ProfilePresenter: ProfileInteractorOutput {
}
