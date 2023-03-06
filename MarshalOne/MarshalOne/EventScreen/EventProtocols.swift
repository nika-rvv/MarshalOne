//
//  EventProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import Foundation

protocol EventModuleInput {
	var moduleOutput: EventModuleOutput? { get }
}

protocol EventModuleOutput: AnyObject {
}

protocol EventViewInput: AnyObject {
}

protocol EventViewOutput: AnyObject {
    func didPressBackButton()
}

protocol EventInteractorInput: AnyObject {
}

protocol EventInteractorOutput: AnyObject {
}

protocol EventRouterInput: AnyObject {
    func backButtonTapped()
}
