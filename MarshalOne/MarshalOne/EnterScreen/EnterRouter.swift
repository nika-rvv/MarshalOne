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
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
}

extension EnterRouter: EnterRouterInput {
    func timerFinished() {
        guard let window = window else {
            return
        }
        if let isRemembered = defaults.value(forKey: "isRemembered") as? Bool, isRemembered != false {
            appCoordinator = AppCoordinator(window: window, instructor: .main)
        } else {
            appCoordinator = AppCoordinator(window: window, instructor: .authorization)
        }
        appCoordinator?.start()
    }
}
