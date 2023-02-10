//
//  LoginProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import Foundation

protocol LoginModuleInput {
	var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: AnyObject {
}

protocol LoginViewInput: AnyObject {
}

protocol LoginViewOutput: AnyObject {
}

protocol LoginInteractorInput: AnyObject {
}

protocol LoginInteractorOutput: AnyObject {
}

protocol LoginRouterInput: AnyObject {
}
