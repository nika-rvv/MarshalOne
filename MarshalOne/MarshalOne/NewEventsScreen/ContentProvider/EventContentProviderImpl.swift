//
//  EventContentProviderImpl.swift
//  MarshalOne
//
//  Created by Veronika on 30.04.2023.
//

import Foundation

final class EventContentProviderImpl: EventContentProvider {    
    private var events: [RaceInfo] = []
    
    func getEvent(by index: Int) -> RaceInfo {
        return events[index]
    }
    
    func appendEvents(_ events: [RaceInfo]) {
        self.events.append(contentsOf: events)
    }
}
