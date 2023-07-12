//
//  MediaEncoder.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation

public struct MediaEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with media: Data) throws {

        urlRequest.httpBody = media
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        }
    }
}
