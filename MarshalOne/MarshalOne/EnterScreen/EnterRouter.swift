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
    var appCoordinator: AuthCoordinator?
    var window: UIWindow?
}

extension EnterRouter: EnterRouterInput {
    func timerFinished() {
        guard let window = window else {
            return
        }
        appCoordinator = AuthCoordinator(window: window)
        appCoordinator?.start()
    }
}
