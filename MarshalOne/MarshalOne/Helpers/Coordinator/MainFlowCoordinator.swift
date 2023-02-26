//
//  MainFlowCoordinator.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//

import UIKit

final class MainFlowCoordinator: CoordinatorProtocol{
    internal var window: UIWindow
    private let tabBar: CustomTabBar
    
    init (window: UIWindow) {
        self.window = window
        self.tabBar = CustomTabBar(window: window)
    }
    
    func start() {
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
