//
//  EnterContainer.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//  
//

import UIKit

final class EnterContainer {
    let input: EnterModuleInput
	let viewController: UIViewController
	private(set) weak var router: EnterRouterInput!

	static func assemble(with context: EnterContext) -> EnterContainer {
        let router = EnterRouter()
        let interactor = EnterInteractor()
        let presenter = EnterPresenter(router: router, interactor: interactor)
		let viewController = EnterViewController(output: presenter)

        router.viewController = viewController
        router.window = context.window
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EnterContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EnterModuleInput, router: EnterRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EnterContext {
	weak var moduleOutput: EnterModuleOutput?
    let window: UIWindow
}
