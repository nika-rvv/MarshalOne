//
//  RegisterContainer.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import UIKit

final class RegisterContainer {
    let input: RegisterModuleInput
	let viewController: UIViewController
	private(set) weak var router: RegisterRouterInput!

	static func assemble(with context: RegisterContext) -> RegisterContainer {
        let router = RegisterRouter()
        let networkRouter = Router<UserEndPoint>()
        let regManager = UserNetworkManagerImpl(router: networkRouter)
        let interactor = RegisterInteractor(userManager: regManager)
        let presenter = RegisterPresenter(router: router, interactor: interactor)
		let viewController = RegisterViewController(output: presenter)

        router.viewController = viewController
        router.window = context.window
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return RegisterContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: RegisterModuleInput, router: RegisterRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct RegisterContext {
	weak var moduleOutput: RegisterModuleOutput?
    let window: UIWindow
}
