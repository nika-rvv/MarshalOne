//
//  ProfileScreenPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

final class ProfileScreenPresenter {
	weak var view: ProfileScreenViewInput?
    weak var moduleOutput: ProfileScreenModuleOutput?
    
	private let router: ProfileScreenRouterInput
	private let interactor: ProfileScreenInteractorInput
    
    init(router: ProfileScreenRouterInput, interactor: ProfileScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfileScreenPresenter: ProfileScreenModuleInput {
}

extension ProfileScreenPresenter: ProfileScreenViewOutput {
}

extension ProfileScreenPresenter: ProfileScreenInteractorOutput {
}
