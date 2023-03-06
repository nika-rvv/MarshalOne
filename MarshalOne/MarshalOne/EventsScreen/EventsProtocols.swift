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

protocol EventsModuleOutput: AnyObject {
}

protocol EventsViewInput: AnyObject {
}

protocol EventsViewOutput: AnyObject {
    func openEventScreen()
}

protocol EventsInteractorInput: AnyObject {
}

protocol EventsInteractorOutput: AnyObject {
}

protocol EventsRouterInput: AnyObject {
    func didtapEvent()
}
