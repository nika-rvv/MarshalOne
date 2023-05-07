//
//  NewEventsRouter.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import UIKit

final class NewEventsRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension NewEventsRouter: NewEventsRouterInput {
    func selectedRowTapped(with id: Int) {
        guard let window = window else {
            return
        }
        let oneEventContext = EventContext(window: window, raceId: id)
        let oneEventContainer = EventContainer.assemble(with: oneEventContext)
        viewController?.navigationController?.pushViewController(oneEventContainer.viewController, animated: true)
    }
}
