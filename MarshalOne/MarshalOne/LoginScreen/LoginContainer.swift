//
//  LoginContainer.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import UIKit

final class LoginContainer {
    let input: LoginModuleInput
	let viewController: UIViewController
	private(set) weak var router: LoginRouterInput!

	static func assemble(with context: LoginContext) -> LoginContainer {
        let router = LoginRouter()
        let networkRouter = Router<UserEndPoint>()
        let authManager = UserNetworkManagerImpl(router: networkRouter)
        let interactor = LoginInteractor(userManager: authManager)
        let presenter = LoginPresenter(router: router, interactor: interactor)
		let viewController = LoginViewController(output: presenter)

        router.viewController = viewController
        router.window = context.window
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return LoginContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LoginModuleInput, router: LoginRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LoginContext {
	weak var moduleOutput: LoginModuleOutput?
    let window: UIWindow
}
