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
    func setLike(raceId: Int) 
    func setDislike(raceId: Int)
}

protocol NewEventsViewOutput: AnyObject {
    func didLoadRaces()
    func didOpenEvent(with index: Int)
    func didSetLike(for index: Int)
    func didUnsetLike(for index: Int)
}

protocol NewEventsInteractorInput: AnyObject {
    func getRacesData()
    func getEvent(by index: Int) -> RaceInfo
    func setLike(for index: Int)
    func setDislike(for index: Int)
}

protocol NewEventsInteractorOutput: AnyObject {
    func setRaces(races: [RaceInfo])
    func setDislike(index: Int)
    func setLike(index: Int)
}

protocol NewEventsRouterInput: AnyObject {
    func selectedRowTapped(with id: Int)
}
