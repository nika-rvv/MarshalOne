//
//  LoginRouter.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import UIKit

final class LoginRouter {
    var viewController: UIViewController?
    var window: UIWindow?
}

extension LoginRouter: LoginRouterInput {
    func openRegScreen() {
        guard let window = window else {
            return
        }
        let registrationContext = RegisterContext(window: window)
        let registrationContainer = RegisterContainer.assemble(with: registrationContext)
        viewController?.navigationController?.pushViewController(registrationContainer.viewController, animated: true)
    }
    
    func openMainFlow() {
        guard let window = window else {
            return
        }
        let coordinator = AppCoordinator(window: window, instructor: .main)
        coordinator.start()
    }
}
