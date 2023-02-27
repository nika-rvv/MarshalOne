//
//  ProfileScreenProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: class {
}

protocol ProfileViewInput: class {
}

protocol ProfileViewOutput: class {
}

protocol ProfileInteractorInput: class {
}

protocol ProfileInteractorOutput: class {
}

protocol ProfileRouterInput: class {
}
