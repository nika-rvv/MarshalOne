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
    func didtapEvent() {
        guard let window = window else {
            return
        }
        
        let eventContext = EventContext(window: window)
        let eventContainer = EventContainer.assemble(with: eventContext)
        let eventViewController = eventContainer.viewController
        viewController?.navigationController?.pushViewController(eventViewController, animated: true)
    }
}
