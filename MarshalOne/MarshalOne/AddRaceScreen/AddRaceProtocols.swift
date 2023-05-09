//
//  AddRaceProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import Foundation

protocol AddRaceModuleInput {
	var moduleOutput: AddRaceModuleOutput? { get }
}

protocol AddRaceModuleOutput: AnyObject {
}

protocol AddRaceViewInput: AnyObject {
    func showEmptyFields(withIndexes: [Int])
}

protocol AddRaceViewOutput: AnyObject {
    func didTapCloseViewControllerButton()
    func didTapAddRace(with raceInfo: [String?])
}

protocol AddRaceInteractorInput: AnyObject {
    func addRace(with raceInfo: [String?])
}

protocol AddRaceInteractorOutput: AnyObject {
    func raceAdded()
}

protocol AddRaceRouterInput: AnyObject {
    func closeViewController() 
}
