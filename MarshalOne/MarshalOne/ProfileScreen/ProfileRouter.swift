//
//  ProfileScreenRouter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

final class ProfileRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func didTapChangeTheme() {
        if window?.overrideUserInterfaceStyle == .dark {
            window?.overrideUserInterfaceStyle = .light
        } else {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    func didTapLogout(){
        guard let window = window else {
            return
        }
        
        let coordinator = AppCoordinator(window: window, instructor: .authorization)
        coordinator.start()
        print("delete")
    }
}
