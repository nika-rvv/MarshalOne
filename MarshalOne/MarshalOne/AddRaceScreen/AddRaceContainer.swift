//
//  AddRaceContainer.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import UIKit

final class AddRaceContainer {
    let input: AddRaceModuleInput
	let viewController: UIViewController
	private(set) weak var router: AddRaceRouterInput!

	static func assemble(with context: AddRaceContext) -> AddRaceContainer {
        let router = AddRaceRouter()
        let networkRouter = Router<RaceEndPoint>()
        let imageRouter = Router<ImageEndPoint>()
        let raceManager = RacesNetworkManagerImpl(router: networkRouter)
        let imageManager = ImageManagerImpl(router: imageRouter)
        let locationDecoder = LocationDecoder()
        let interactor = AddRaceInteractor(raceManager: raceManager, locationDecoder: locationDecoder, imageManager: imageManager)
        let presenter = AddRacePresenter(router: router, interactor: interactor)
		let viewController = AddRaceViewController(output: presenter)

        router.viewController = viewController
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return AddRaceContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AddRaceModuleInput, router: AddRaceRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AddRaceContext {
	weak var moduleOutput: AddRaceModuleOutput?
}
