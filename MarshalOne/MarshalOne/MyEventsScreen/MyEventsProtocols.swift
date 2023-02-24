//
//  MyEventsProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import Foundation

protocol MyEventsModuleInput {
	var moduleOutput: MyEventsModuleOutput? { get }
}

protocol MyEventsModuleOutput: class {
}

protocol MyEventsViewInput: class {
}

protocol MyEventsViewOutput: class {
}

protocol MyEventsInteractorInput: class {
}

protocol MyEventsInteractorOutput: class {
}

protocol MyEventsRouterInput: class {
}
