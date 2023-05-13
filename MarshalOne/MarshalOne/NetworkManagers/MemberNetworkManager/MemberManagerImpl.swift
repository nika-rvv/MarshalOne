//
//  MemberManagerImpl.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation
final class MemberManagerImpl: NetworkManager, MemberManager {
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
    }
    
    func postMember(with id: Int) async -> String? {
        let result = await router.request(.postMember(raceId: id))

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
    
    func deleteMember(with id: Int) async -> String? {
        let result = await router.request(.deleteMember(raceId: id))

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
    
    func getMember(with id: Int) async -> (isMember: Bool?, error: String?) {
        let result = await router.request(.getMember(raceId: id))


        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try? JSONDecoder().decode(Member.self, from: responseData)
                return (apiResponse?.isMember, nil)
            }
            catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
        case let .failure(reason):
            return (nil, reason)
        }
    }
    
}
