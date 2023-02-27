//
//  AuthCoordinator.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    internal var window: UIWindow
    private lazy var navigationControllers = AuthCoordinator.makeNavigationControllers()
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupLogin()
        
        let navControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }

        window.rootViewController = navControllers[0]
        window.makeKeyAndVisible()
    }
    
    enum LaunchInstructor {
        case login, registration
    }
}

extension AuthCoordinator {
    
    private func setupLogin() {
        guard let navController = navigationControllers[.auth] else {
            print("No navController")
            return
        }
        let loginContext = LoginContext(window: window)
        let loginContainer = LoginContainer.assemble(with: loginContext)
        navController.setViewControllers([loginContainer.viewController], animated: true)
    }
    
    fileprivate static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            result[navControllerKey] = navigationController
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case auth
}
