import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание контроллеров представлений
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        
        // Задание заголовков и изображений для контроллеров представлений
        vc1.title = "First"
        vc1.tabBarItem.image = UIImage(named: "first")
        
        vc2.title = "Second"
        vc2.tabBarItem.image = UIImage(named: "second")
        
        vc3.title = "Third"
        vc3.tabBarItem.image = UIImage(named: "third")
        
        // Массив контроллеров представлений
        let viewControllers = [vc1, vc2, vc3]
        
        // Задание контроллеров представлений в TabBar
        self.viewControllers = viewControllers
        
        // Настройка выделения большой кнопки
        let centerButton = UIButton(type: .custom)
        centerButton.setImage(UIImage(named: "center"), for: .normal)
        centerButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        centerButton.center = CGPoint(x: self.tabBar.center.x, y: self.tabBar.bounds.height / 2 - 10)
        self.tabBar.addSubview(centerButton)
        
        // Добавление действия на большую кнопку
        centerButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    // Обработчик нажатия на большую кнопку
    @objc func buttonAction() {
        // Открытие нужного экрана
        let newViewController = UIViewController()
        newViewController.title = "New"
        newViewController.view.backgroundColor = .red
        navigationController?.present(newViewController, animated: true)
    }
}
