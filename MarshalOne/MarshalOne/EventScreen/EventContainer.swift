//
//  EventContainer.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import UIKit

final class EventContainer {
    let input: EventModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventRouterInput!

	static func assemble(with context: EventContext) -> EventContainer {
        let router = EventRouter()
        let networkRouter = Router<RaceEndPoint>()
        let raceManager = RacesNetworkManagerImpl(router: networkRouter)
        let raceId = context.raceId
        let interactor = EventInteractor(raceManager: raceManager, raceId: raceId)
        let presenter = EventPresenter(router: router, interactor: interactor)
		let viewController = EventViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.window = context.window
        router.viewController = viewController

		interactor.output = presenter

        return EventContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventModuleInput, router: EventRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventContext {
	weak var moduleOutput: EventModuleOutput?
    let window: UIWindow
    let raceId: Int
}
