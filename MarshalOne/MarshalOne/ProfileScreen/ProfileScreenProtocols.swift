//
//  ProfileScreenProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

protocol ProfileScreenModuleInput {
	var moduleOutput: ProfileScreenModuleOutput? { get }
}

protocol ProfileScreenModuleOutput: class {
}

protocol ProfileScreenViewInput: class {
}

protocol ProfileScreenViewOutput: class {
}

protocol ProfileScreenInteractorInput: class {
}

protocol ProfileScreenInteractorOutput: class {
}

protocol ProfileScreenRouterInput: class {
}
