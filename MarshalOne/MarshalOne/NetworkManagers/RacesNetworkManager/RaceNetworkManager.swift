//
//  RaceNetworkManager.swift
//  MarshalOne
//
//  Created by Veronika on 26.03.2023.
//

import Foundation
protocol RacesNetworkManager {
    func getListOfRaces() async -> (races: [RaceListElement]?, error: String?)
    func getRace(with id: Int) async -> (race: OneRace?, error: String?)
    func postView(with id: Int) async -> String?
    func postRace(with raceInfo: AddRace) async -> String?
    func putRace(with id: Int) async -> String?
}
