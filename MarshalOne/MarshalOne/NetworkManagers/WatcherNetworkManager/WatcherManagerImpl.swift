//
//  WatcherManagerImpl.swift
//  MarshalOne
//
//  Created by Veronika on 07.05.2023.
//

import Foundation

final class WatcherManagerImpl: NetworkManager, WatcherManager {
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
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
}
