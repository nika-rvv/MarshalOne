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
    func setData(raceData: OneEventInfo)
    func addMember()
    func deleteMember()
}

protocol EventViewOutput: AnyObject {
    func didPressBackButton()
    func loadRaceInfo()
    func postParticipant()
    func deleteParticipant()
}

protocol EventInteractorInput: AnyObject {
    func loadInfo()
    func didPostParticipant()
    func didDeleteParticipant()
}

protocol EventInteractorOutput: AnyObject {
    func setRace(races: OneEventInfo) async
    func setMember()
    func removeMember()
}

protocol EventRouterInput: AnyObject {
    func backButtonTapped()
}
