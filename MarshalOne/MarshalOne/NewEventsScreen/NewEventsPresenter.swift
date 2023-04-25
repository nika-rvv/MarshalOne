//
//  NewEventsPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import Foundation
import CoreLocation

final class NewEventsPresenter {
	weak var view: NewEventsViewInput?
    weak var moduleOutput: NewEventsModuleOutput?
    
	private let router: NewEventsRouterInput
	private let interactor: NewEventsInteractorInput
    
    init(router: NewEventsRouterInput, interactor: NewEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func makeRaceInfo(raceList: RaceList) async -> [RaceInfo] {
        var raceInfo: [RaceInfo] = []
        
        for elem in raceList {
            let race = RaceInfo(title: elem.name,
                                dateSubtitle: formatDate(dateFrom: elem.date.from,
                                                         dateTo: elem.date.to),
                                placeName: await formatLocation(from: elem.location.longitude,
                                                          and: elem.location.latitude),
                                imageId: elem.images[safe: 0] ?? "",
                                numberOfLikes: elem.likes,
                                numberOfParticipants: elem.members.count,
                                numberOfWatchers: elem.views,
                                isLiked: true)
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

extension NewEventsPresenter: NewEventsModuleInput {
}

extension NewEventsPresenter: NewEventsViewOutput {
    func didLoadRaces() {
        interactor.getRacesData()
    }
    
}

extension NewEventsPresenter: NewEventsInteractorOutput {
    func setRaces(races: RaceList) {
        Task {
            let info = await makeRaceInfo(raceList: races)
            await MainActor.run {
                view?.update(withRaces: info)
            }
        }
    }
}
