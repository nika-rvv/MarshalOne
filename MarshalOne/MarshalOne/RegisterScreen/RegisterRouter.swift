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
}
