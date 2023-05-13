//
//  HTTPTask.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation

public typealias HTTPHeaders = [String:String]
public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders)
    
    case uploadImage(image: Data)
}
