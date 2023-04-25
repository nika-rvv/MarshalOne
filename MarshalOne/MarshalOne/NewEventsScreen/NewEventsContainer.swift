//
//  NewEventsContainer.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import UIKit

final class NewEventsContainer {
    let input: NewEventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: NewEventsRouterInput!

	static func assemble(with context: NewEventsContext) -> NewEventsContainer {
        let router = NewEventsRouter()
        let networkRouter = Router<RaceEndPoint>()
        let racesManager = RacesNetworkManagerImpl(router: networkRouter)
        let interactor = NewEventsInteractor(racesManager: racesManager)
        let presenter = NewEventsPresenter(router: router, interactor: interactor)
		let viewController = NewEventsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return NewEventsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: NewEventsModuleInput, router: NewEventsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct NewEventsContext {
	weak var moduleOutput: NewEventsModuleOutput?
}
