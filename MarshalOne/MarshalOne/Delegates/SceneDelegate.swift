//
//  SceneDelegate.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window: UIWindow = UIWindow(windowScene: windowScene)
        self.window = window
        
        let enterContainer = EnterContainer.assemble(with: EnterContext())
        let navigationController = UINavigationController(rootViewController: enterContainer.viewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

