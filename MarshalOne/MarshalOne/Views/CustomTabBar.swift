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
        setViewControllers([
            configureViewController(with: setupEvents(),
                                    with: R.string.localizable.events(),
                                    and: R.image.events()),
            configureViewController(with: setupAddRace(),
                                    with: R.string.localizable.addRace(),
                                    and: R.image.myEvents()),
            configureViewController(with: setupProfile(),
                                    with: R.string.localizable.profile(),
                                    and: R.image.profile())
        ],
                           animated: true)
        
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
        let myEventsContext = AddRaceContext(moduleOutput: nil)
        let myEventsContainer = AddRaceContainer.assemble(with: myEventsContext)
        return myEventsContainer.viewController
    }
    
    private func setupProfile() -> UIViewController {
        let profileContext = ProfileContext(window: window)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        return profileContainer.viewController
    }
    
    private func setupUI() {
        let positionX: CGFloat = 10.0
        let positionY: CGFloat = 10.0
        
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX,
                                                          y: tabBar.bounds.minY - positionY,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = R.color.tabBarColor()?.cgColor
        tabBar.tintColor = R.color.mainOrange()
        tabBar.unselectedItemTintColor = R.color.mainBlue()
    }
}
