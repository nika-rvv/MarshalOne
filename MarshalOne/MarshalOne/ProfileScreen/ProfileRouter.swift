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
    func didTapDeleteAcount() {
        guard let window = window else {
            return
        }
        
        let coordinator = AppCoordinator(window: window, instructor: .authorization)
        coordinator.start()
        print("delete")
    }
    
    func didTapLogout(){
        guard let window = window else {
            return
        }
        
        let coordinator = AppCoordinator(window: window, instructor: .authorization)
        coordinator.start()
        print("logout")
    }
}
