//
//  NewEventsInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import Foundation
import CoreLocation

final class NewEventsInteractor {
    weak var output: NewEventsInteractorOutput?
    private let racesManager: RacesNetworkManager
    private let contentProvider: EventContentProvider
    private let likeManager: LikeManager
    
    init(racesManager: RacesNetworkManager, contentProvider: EventContentProvider, likeManager: LikeManager) {
        self.racesManager = racesManager
        self.contentProvider = contentProvider
        self.likeManager = likeManager
    }
    
    func updateRaces(with raceInfo: [RaceInfo]?) async {
        if let raceInfo = raceInfo {
            await MainActor.run {
                self.output?.setRaces(races: raceInfo)
            }
        }
    }
    
    private func makeRaceInfo(raceList: RaceList) async -> [RaceInfo] {
        var raceInfo: [RaceInfo] = []
        
        for elem in raceList {
            let race = RaceInfo(id: elem.raceId,
                                title: elem.name,
                                dateSubtitle: formatDate(dateFrom: elem.date.from,
                                                         dateTo: elem.date.to),
                                placeName: await formatLocation(from: elem.location.longitude,
                                                                and: elem.location.latitude),
                                imageId: elem.images[safe: 0] ?? "",
                                numberOfLikes: elem.likes,
                                numberOfParticipants: elem.members.count,
                                numberOfWatchers: elem.views,
                                isLiked: elem.isLiked)
            raceInfo.append(race)
        }
        
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

extension NewEventsInteractor: NewEventsInteractorInput {
    func getEvent(by index: Int) -> RaceInfo {
        return contentProvider.getEvent(by: index)
    }
    
    func getRacesData() {
        Task {
            let racesInfo = await racesManager.getListOfRaces()
            if racesInfo.error != nil {
                print(racesInfo.error)
            } else {
                if let races = racesInfo.races  {
                    let recievedAndConvertedRaceInfo = await makeRaceInfo(raceList: races)
                    contentProvider.appendEvents(recievedAndConvertedRaceInfo)
                    await updateRaces(with: recievedAndConvertedRaceInfo)
                } else {
                    print("racesInfo is nil")
                }
            }
        }
    }
    
    func setDislike(for index: Int) {
        Task {
            let race = contentProvider.getEvent(by: index)
            let error = await likeManager.deleteLike(with: race.id)
            
            if error == nil {
                await MainActor.run{
                    self.output?.setDislike(index: index)
                }
            }
        }
    }
    
    func setLike(for index: Int) {
        Task {
            let race = contentProvider.getEvent(by: index)
            let error = await likeManager.postLike(with: race.id)
            
            if error == nil {
                await MainActor.run{
                    self.output?.setLike(index: index)
                }
            }
        }
    }
}
