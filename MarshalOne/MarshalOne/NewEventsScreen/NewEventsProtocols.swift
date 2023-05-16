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
    func addWatcher(raceId: Int)
    func showError(error: String?)
    func showLoaderView()
    func hideLoaderView()
}

protocol NewEventsViewOutput: AnyObject {
    func didLoadRaces()
    func didOpenEvent(with index: Int)
    func didSetLike(for index: Int)
    func didUnsetLike(for index: Int)
    func showLoader()
}

protocol NewEventsInteractorInput: AnyObject {
    func getRacesData()
    func getEvent(by index: Int) -> RaceInfo
    func setLike(for index: Int)
    func setDislike(for index: Int)
    func setWatcher(for index: Int)
}

protocol NewEventsInteractorOutput: AnyObject {
    func setRaces(races: [RaceInfo])
    func setDislike(index: Int)
    func setLike(index: Int)
    func setWatcher(index: Int)
    func showError(error: String?)
}

protocol NewEventsRouterInput: AnyObject {
    func selectedRowTapped(with id: Int)
}
