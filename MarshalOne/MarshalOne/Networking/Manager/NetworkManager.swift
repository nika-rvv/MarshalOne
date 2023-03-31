//
//  NetworkManager.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation

class NetworkManager {
    enum NetworkResponse: String {
        case success
        case authentificationError = "You need to be authentificated first"
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated"
        case failed = "Network request failed"
        case noData = "Response returned with no data to decode"
        case unableToDecode = "We could not decode the response"
    }

    enum Result {
        case success
        case failure(String?)
    }
    
    static let environment: NetworkEnvironment = .debug
    static let additionalHeader: HTTPHeaders = ["":""]

    func handleNetworkResponse(_ response : HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...499:
            return .failure(NetworkResponse.authentificationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    internal func getStatus(response: URLResponse?) -> Result {
        guard let response = response else {
            return .failure("Network request failed")
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure("No response")
        }
        let status = handleNetworkResponse(httpResponse)
        return status
    }
}

