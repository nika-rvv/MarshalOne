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
    func setLikeData(index: Int)
    func updateRace(raceId: Int)
    func setView(index: Int)
}

protocol EventsViewOutput: AnyObject {
    func openEvent(with index: Int)
    func didSetLike(for raceId: Int)
    func didLoadRaces()
    func updateEvent(with index: Int)
    func didUnsetLike(for raceId: Int)
}

protocol EventsInteractorInput: AnyObject {
    func setView(for raceId: Int)
    func getRacesData()
    func setLike(for raceId: Int)
    func setDislike(for raceId: Int)
    func updateRaceAtIndex(for raceId: Int) 
}

protocol EventsInteractorOutput: AnyObject {
    func setRaces(races: RaceList)
    func setLike(raceId: Int)
    func updateRace(raceId: Int)
    func setViews(raceId: Int)
    func setDislike(raceId: Int)
}

protocol EventsRouterInput: AnyObject {
    func selectedRowTapped(at index: Int)
}
