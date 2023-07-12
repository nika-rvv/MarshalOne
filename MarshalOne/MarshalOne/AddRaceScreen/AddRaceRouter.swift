//
//  AddRaceRouter.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import UIKit

final class AddRaceRouter {
    var viewController: UIViewController?
}

extension AddRaceRouter: AddRaceRouterInput {
    func closeViewController() {
        viewController?.dismiss(animated: true)
    }
}
