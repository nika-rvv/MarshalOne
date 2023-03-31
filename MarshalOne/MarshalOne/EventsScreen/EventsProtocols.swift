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
    func setData(raceData: RaceList)
}

protocol EventsViewOutput: AnyObject {
    func openEventScreen()
    func didLoadRaces()
}

protocol EventsInteractorInput: AnyObject {
    func getRacesData()
}

protocol EventsInteractorOutput: AnyObject {
    func setRaces(races: RaceList)
}

protocol EventsRouterInput: AnyObject {
    func didtapEvent()
}
