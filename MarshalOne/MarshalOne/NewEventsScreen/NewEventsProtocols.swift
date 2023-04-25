//
//  NewEventsProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import Foundation

protocol NewEventsModuleInput {
	var moduleOutput: NewEventsModuleOutput? { get }
}

protocol NewEventsModuleOutput: AnyObject {
}

protocol NewEventsViewInput: AnyObject {
    func update(withRaces races: [RaceInfo])
}

protocol NewEventsViewOutput: AnyObject {
    func didLoadRaces()
}

protocol NewEventsInteractorInput: AnyObject {
    func getRacesData()
}

protocol NewEventsInteractorOutput: AnyObject {
    func setRaces(races: RaceList)
}

protocol NewEventsRouterInput: AnyObject {
}
