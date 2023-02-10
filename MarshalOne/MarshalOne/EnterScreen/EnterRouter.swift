//
//  EnterRouter.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//  
//

import UIKit

final class EnterRouter {
    var viewController: UIViewController?
    var window: UIWindow?
}

extension EnterRouter: EnterRouterInput {
    func timerFinished() {
        guard let window = window else {
            return
        }
        let loginContext = LoginContext(window: window)
        let loginContainer = LoginContainer.assemble(with: loginContext)
        
        window.rootViewController = loginContainer.viewController
        window.makeKeyAndVisible()
    }
}
