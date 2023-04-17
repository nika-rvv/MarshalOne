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
}

protocol AddRaceViewOutput: AnyObject {
    func didTapCloseViewControllerButton()
}

protocol AddRaceInteractorInput: AnyObject {
    func addRace(with raceInfo: [String?])
}

protocol AddRaceInteractorOutput: AnyObject {
}

protocol AddRaceRouterInput: AnyObject {
    func closeViewController() 
}
