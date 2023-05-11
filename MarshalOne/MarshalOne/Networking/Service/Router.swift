//
//  Router.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation
final class Router<EndPoint: EndPointType>: NetworkRouter {

    private var tasks: [Task<(Data?, URLResponse?, Error?), Error>] = []
    
    func request(_ route: EndPoint) async -> (data: Data?, response: URLResponse?, error: Error?) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            let task = Task { () -> (Data?, URLResponse?, Error?) in
                let (data, response) = try await session.data(for: request)
                return (data, response, nil)
            }
            
            tasks.append(task)
            return try await task.value
        } catch NetworkError.encodingFailed {
            return (nil, nil, NetworkError.encodingFailed)
        } catch {
            return (nil, nil, NetworkError.noInternetConnection)
        }
    }
    
    func cancelAll() {
        self.tasks.forEach { $0.cancel() }
    }
    
    func cancel(index: Int) {
        self.tasks[index].cancel()
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
//        guard let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
//            return request
//        }
        
        
//        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case let .requestParametersAndHeaders(bodyParameters: bodyParameters,
                                                  urlParameters: urlParameters,
                                                  additionHeaders: additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?,
                                          request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
