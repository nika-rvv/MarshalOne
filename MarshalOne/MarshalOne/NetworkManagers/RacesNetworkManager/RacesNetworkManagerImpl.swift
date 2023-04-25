//
//  RacesNetworkManagerImpl.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import Foundation

final class RacesNetworkManagerImpl: NetworkManager, RacesNetworkManager {
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
    }
    
    func getListOfRaces() async -> (races: [RaceListElement]?, error: String?) {
        let result = await router.request(.getListOfRaces)
        if result.error != nil {
            return (nil, "Check network connection")
        }
        
        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return(nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try? JSONDecoder().decode(RaceList.self, from: responseData)
                return (apiResponse, nil)
            } catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
        case let .failure(reason):
            return (nil, reason)
        }
    }
    
    func getRace(with id: Int) async -> (race: OneRace?, error: String?) {
        let result = await router.request(.getRace(raceId: id))
        if result.error != nil {
            return (nil, "Check your connection")
        }
        
        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try? JSONDecoder().decode(OneRace.self, from: responseData)
                return (apiResponse, nil)
            }
            catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
        case let .failure(reason):
            return (nil, reason)
        }
    }
        
    func postView(with id: Int) async -> String? {
        let result = await router.request(.postView(raceId: id))
        if result.error != nil {
            return "Check connection"
        }
        
        switch getStatus(response: result.response) {
        case .success:
            if result.data == nil {
                return NetworkResponse.noData.rawValue
            }
            return nil
        case let .failure(reason):
            return reason
        }
    }
    
    func postRace(with raceInfo: AddRace) async -> String? {
        let result = await router.request(.postRace(raceInfo: raceInfo))
        
        if result.error != nil {
            return "Check connection"
        }
        
        switch getStatus(response: result.response) {
        case .success:
            if result.data == nil {
                return NetworkResponse.noData.rawValue
            }
            return nil
        case let .failure(reason):
            return reason
        }
    }
    
    func putRace(with id: Int) async -> String? {
        let result = await router.request(.putRace(raceId: id))
        
        if result.error != nil {
            return "Check connection"
        }
        
        switch getStatus(response: result.response) {
        case .success:
            if result.data == nil {
                return NetworkResponse.noData.rawValue
            }
            return nil
        case let .failure(reason):
            return reason
        }
    }
}
