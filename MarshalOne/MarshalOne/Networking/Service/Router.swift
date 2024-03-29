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
            print(request.url)
            print(try? JSONSerialization.jsonObject(with: request.httpBody ?? Data()))
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
        request.httpShouldHandleCookies = true

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters, media: nil,
                                             request: &request)
            case let .requestParametersAndHeaders(bodyParameters: bodyParameters,
                                                  urlParameters: urlParameters,
                                                  additionHeaders: additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             media: nil,
                                             request: &request)
            case let .uploadImage(image: image):
                try self.configureParameters(bodyParameters: nil,
                                             urlParameters: nil,
                                             media: image,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         media: Data?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            if let media = media {
                try MediaEncoder.encode(urlRequest: &request, with: media)
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
