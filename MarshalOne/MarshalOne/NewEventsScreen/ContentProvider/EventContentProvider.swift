//
//  EventContentProvider.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import Foundation

protocol EventContentProvider {
    func getEvent(by index: Int) -> RaceInfo
    func appendEvents(_ events: [RaceInfo])
}
