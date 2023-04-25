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
    func setData(raceData: OneRace)
}

protocol EventViewOutput: AnyObject {
    func didPressBackButton()
    func loadRaceInfo()
}

protocol EventInteractorInput: AnyObject {
    func loadInfo()
}

protocol EventInteractorOutput: AnyObject {
    func setRace(races: OneRace)
}

protocol EventRouterInput: AnyObject {
    func backButtonTapped()
}
