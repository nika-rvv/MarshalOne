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
}

protocol ProfileRouterInput: AnyObject {
    func didTapLogout()
    func didTapChangeTheme()
}
