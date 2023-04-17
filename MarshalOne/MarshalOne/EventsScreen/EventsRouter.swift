//
//  EventsRouter.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

final class EventsRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension EventsRouter: EventsRouterInput {
    func selectedRowTapped(at index: Int){
        guard let window = window else {
            return
        }
        let oneEventContext = EventContext(window: window, raceId: index)
        let oneEventContainer = EventContainer.assemble(with: oneEventContext)
        viewController?.navigationController?.pushViewController(oneEventContainer.viewController, animated: true)
    }
}
