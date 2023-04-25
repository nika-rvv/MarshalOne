//
//  RaceEndPoint.swift
//  MarshalOne
//
//  Created by Veronika on 26.03.2023.
//

import Foundation

enum RaceEndPoint {
    case getAllRaces
    case getRace(raceId: Int)
    case getListOfRaces
    case postLike(raceId: Int)
    case postView(raceId: Int)
    case putRace(raceId: Int)
    case postRace(raceInfo: AddRace)
    case deleteLike(raceId: Int)
}

extension RaceEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.environment {
        case .qa:
            return "https://onwheels.enula.ru/api/Race"
        case .production:
            return "https://onwheels.enula.ru/api/Race"
        case .debug:
            return "https://onwheels.enula.ru/api/Race"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: enviromentslBaseUrl) else {
            fatalError("Base url is invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllRaces:
            return "/filter"
        case .getRace(let raceId):
            return "/\(raceId)"
        case .getListOfRaces:
            return "/list"
        case .postLike(let raceId):
            return "/\(raceId)/like"
        case .postView(let raceId):
            return "/\(raceId)/view"
        case .putRace(raceId: let raceId):
            return "/\(raceId)"
        case .postRace(raceInfo: let raceInfo):
            return ""
        case .deleteLike(raceId: let raceId):
            return "/\(raceId)/like"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllRaces:
            return .get
        case .getRace(raceId: _):
            return .get
        case .getListOfRaces:
            return .get
        case .postLike(raceId: _):
            return .post
        case .postView(raceId: _):
            return .post
        case .putRace(raceId: _):
            return .put
        case .postRace(raceInfo: _):
            return .post
        case .deleteLike(raceId: _):
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllRaces:
            return .requestParameters(bodyParameters: ["":""],
                                      urlParameters: nil)
        case .getRace(_):
            return .request
        case .getListOfRaces:
            return .request
        case .postView(_):
            return .request
        case .postLike(_):
            return .request
        case .putRace:
            return .request
        case let .postRace(raceInfo: raceInfo):
            return .requestParameters(bodyParameters: [
                "name": raceInfo.name,
                "location": ["longitude" : raceInfo.location.longitude,
                             "latitude" : raceInfo.location.latitude],
                "date": ["from" : raceInfo.date.from,
                         "to" : raceInfo.date.to],
                "description": raceInfo.oneRaceDescription,
                "imageUrls": raceInfo.images,
                "tags": raceInfo.tags
            ], urlParameters: nil)
        case .deleteLike(raceId: _):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
