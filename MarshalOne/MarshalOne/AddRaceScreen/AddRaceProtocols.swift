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
    func showError(with error: String)
}

protocol AddRaceViewOutput: AnyObject {
    func didTapCloseViewControllerButton()
    func didTapAddRace(with raceInfo: [String?], and imageData: Data?)
}

protocol AddRaceInteractorInput: AnyObject {
    func addRace(with raceInfo: [String?], and imageData: Data?)
}

protocol AddRaceInteractorOutput: AnyObject {
    func raceAdded()
    func showEror(with error: String)
}

protocol AddRaceRouterInput: AnyObject {
    func closeViewController() 
}
