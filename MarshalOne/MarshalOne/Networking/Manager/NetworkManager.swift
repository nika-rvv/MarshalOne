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
        case authentificationError = "Неправильные почта или пароль"
        case badRequest = "Плохой запрос"
        case outdated = "Запрашиваемый вами адрес устарел"
        case failed = "Сбой сетевого запроса"
        case noData = "Ответ возвращен без данных для декодирования"
        case unableToDecode = "Мы не смогли расшифровать ответ"
        case authError = "Сначала вам нужно пройти аутентификацию"
        case wrongPassword = "Неверный пароль или email"
        case notFound = "Код 404, не найдено"
        case thisEmailAlreadyExists = "Эта почта уже занята"
        case serverError = "У нас на сервере что-то произошло, мы уже все чиним"
    }

    enum Result {
        case success
        case failure(String?)
    }
    
    static let environment: NetworkEnvironment = .debug
    static let additionalHeader: HTTPHeaders = ["" : ""]
    

    func handleNetworkResponse(_ response : HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401:
             return .failure(NetworkResponse.authError.rawValue)
         case 403:
             return .failure(NetworkResponse.wrongPassword.rawValue)
         case 422:
             return .failure(NetworkResponse.badRequest.rawValue)
         case 404:
             return .failure(NetworkResponse.notFound.rawValue)
         case 409:
             return .failure(NetworkResponse.thisEmailAlreadyExists.rawValue)
        case 501...599:
            return .failure(NetworkResponse.serverError.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    internal func getStatus(response: URLResponse?) -> Result {
        guard let response = response else {
            return .failure("Сбой сетевого запроса")
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure("Нет ответа")
        }
        let status = handleNetworkResponse(httpResponse)
        return status
    }
}

