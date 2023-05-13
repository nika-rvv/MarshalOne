//
//  EventInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import Foundation
import CoreLocation

final class EventInteractor {
	weak var output: EventInteractorOutput?
    
    private let raceManager: RacesNetworkManager
    private let memberManager: MemberManager
    private let raceId: Int
    
    init(raceManager: RacesNetworkManager, memberManager: MemberManager, raceId: Int) {
        self.raceManager = raceManager
        self.memberManager = memberManager
        self.raceId = raceId
    }
    
    private func makeOneRaceInfo(raceInfo: OneRace, isMember: Bool) async -> OneEventInfo {
        let raceInfo = OneEventInfo(title: raceInfo.name,
                                    dateSubtitle: formatDate(dateFrom: raceInfo.date.from,
                                                             dateTo: raceInfo.date.to),
                                    latitude: raceInfo.location.latitude,
                                    longitude: raceInfo.location.longitude,
                                    placeName: await formatLocation(from: raceInfo.location.longitude,
                                                                    and: raceInfo.location.latitude),
                                    imageId: raceInfo.images[safe: 0] ?? "",
                                    description: raceInfo.oneRaceDescription,
                                    isMember: isMember)
        
        return raceInfo
    }
    
    private func formatLocation(from longitude: Double, and latitude: Double) async -> String {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let cityLoc: String = await location.fetchCityAndCountry() ?? ""
        
        return cityLoc
    }
    
    private func formatDate(dateFrom: String, dateTo: String) -> String {
        var fromDateString = ""
        var toDateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let dateFrom = inputFormatter.date(from: dateFrom) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            fromDateString = outputFormatter.string(from: dateFrom)
        } else {
            fromDateString = "Error"
        }
        
        if let dateTo = inputFormatter.date(from: dateTo) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            toDateString = outputFormatter.string(from: dateTo)
        }
        
        return "\(fromDateString) - \(toDateString)"
    }
}

extension EventInteractor: EventInteractorInput {
    func loadInfo() {
        Task {
            let result = await raceManager.getRace(with: raceId)
            
            let isMember = await memberManager.getMember(with: raceId)
            
            if let error = result.error {
                print(error)
            }
            
            if let race = result.race, let member = isMember.isMember {
                let convertedRaceInfo = await makeOneRaceInfo(raceInfo: race, isMember: member)
                await self.output?.setRace(races: convertedRaceInfo)
            }
        }
    }
    
    func didPostParticipant() {
        Task {
            let result = await memberManager.postMember(with: raceId)
            
            if result == nil {
                await MainActor.run {
                    self.output?.setMember()
                }
            }
        }
    }
    
    func didDeleteParticipant() {
        Task {
            let result = await memberManager.deleteMember(with: raceId)
            
            if result == nil {
                await MainActor.run {
                    self.output?.removeMember()
                }
            }
        }
    }
}
