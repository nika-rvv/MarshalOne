//
//  RegisterRouter.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import UIKit

final class RegisterRouter {
    var viewController: UIViewController?
    var window: UIWindow?
}

extension RegisterRouter: RegisterRouterInput {
    func backButtonTapped(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openMainFlow() {
        guard let window = window else {
            return
        }
        let coordinator = AppCoordinator(window: window, instructor: .main)
        coordinator.start()
    }
}
