//
//  ProfileScreenProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func getData(userData: CurrentUser)
    func showLoaderView()
    func hideLoaderView()
    func showError(with error: String)
}

protocol ProfileViewOutput: AnyObject {
    func didLogoutViewTap()
    func didChangeThemeViewTap()
    func loadInfo()
}

protocol ProfileInteractorInput: AnyObject {
    func loadUserInfo()
}

protocol ProfileInteractorOutput: AnyObject {
    func setUserData(user: CurrentUser)
    func showError(with error: String)
}

protocol ProfileRouterInput: AnyObject {
    func didTapLogout()
    func didTapChangeTheme()
}
