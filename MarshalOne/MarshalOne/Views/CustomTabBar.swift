//
//  CustomTabBar.swift
//  MarshalOne
//
//  Created by Veronika on 26.02.2023.
//

import UIKit
final class CustomTabBar: UITabBarController {
    var window: UIWindow
    
    init (window: UIWindow) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
}
extension CustomTabBar {
    func configureTabBar() {
        let eventsViewController = setupEvents()
        eventsViewController.tabBarItem = UITabBarItem(title: R.string.localizable.events(), image: R.image.events(), tag: 0)
        let eventsNavigationController = UINavigationController(rootViewController: eventsViewController)
        
        let addRaceViewController = setupAddRace()
        let addRaceNavigationController = UINavigationController(rootViewController: addRaceViewController)
        
        let profileViewController = setupProfile()
        profileViewController.tabBarItem = UITabBarItem(title: R.string.localizable.profile(), image: R.image.profile(), tag: 2)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        viewControllers = [eventsNavigationController, addRaceNavigationController, profileNavigationController]
        
        setupMiddleButton()
        setupUI()
    }
    
    func configureViewController(with viewController: UIViewController, with title: String, and image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupEvents() -> UIViewController {
        let eventsContext = EventsContext(window: window)
        let eventsContainer = EventsContainer.assemble(with: eventsContext)
        return eventsContainer.viewController
    }
    
    private func setupAddRace() -> UIViewController {
        let addRaceContext = AddRaceContext(moduleOutput: nil)
        let addRaceContainer = AddRaceContainer.assemble(with: addRaceContext)
        return addRaceContainer.viewController
    }
    
    private func setupProfile() -> UIViewController {
        let profileContext = ProfileContext(window: window)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        return profileContainer.viewController
    }
    
    private func setupUI() {
        let positionX: CGFloat = 10.0
        tabBar.itemWidth = (tabBar.bounds.width - positionX * 2) / 5
        tabBar.itemPositioning = .centered
        tabBar.isTranslucent = false
        tabBar.tintColor = R.color.mainOrange()
        tabBar.unselectedItemTintColor = R.color.mainBlue()
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - 1.5 * menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width / 2 - menuButtonFrame.size.width / 2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = R.color.mainOrange()
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(R.image.addRace(), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc
    func menuButtonAction(sender: UIButton) {
        selectedIndex = 1
        print(selectedIndex)
    }
}


