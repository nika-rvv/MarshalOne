//
//  EventRouter.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import UIKit

final class EventRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension EventRouter: EventRouterInput {
    func backButtonTapped() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
