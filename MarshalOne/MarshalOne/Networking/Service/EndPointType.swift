//
//  EndPointType.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
