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
        case .putRace(raceId: _):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
