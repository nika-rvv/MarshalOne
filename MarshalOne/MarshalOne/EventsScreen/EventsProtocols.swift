//
//  EventsProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

protocol EventsModuleInput {
	var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: class {
}

protocol EventsViewInput: class {
}

protocol EventsViewOutput: class {
}

protocol EventsInteractorInput: class {
}

protocol EventsInteractorOutput: class {
}

protocol EventsRouterInput: class {
}
