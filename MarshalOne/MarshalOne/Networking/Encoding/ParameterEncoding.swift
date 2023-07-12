//
//  ParameterEncoding.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation
public typealias Parameters = [String:Any]


public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Параметры нулевые"
    case encodingFailed = "Сбой кодирования параметров"
    case missingURL = "URL равен нулю"
    case noInternetConnection = "No connection"
}
