//
//  LikeManagerImpl.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import Foundation

final class LikeManagerImpl: NetworkManager, LikeManager {
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
    }
    
    func postLike(with id: Int) async -> String? {
        let result = await router.request(.postLike(raceId: id))

        switch getStatus(response: result.response) {
        case .success:
            if let _ = result.data {
                return nil
            }
            return NetworkResponse.noData.rawValue
        case let .failure(reason):
            return reason
        }
    }
    
    func deleteLike(with id: Int) async -> String? {
        let result = await router.request(.deleteLike(raceId: id))
        
        switch getStatus(response: result.response) {
        case .success:
            if let _ = result.data {
                return nil
            }
            return NetworkResponse.noData.rawValue
        case let .failure(reason):
            return reason
        }
    }
}
