//
//  Media.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation

public struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init(withImageData data: Data, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "profile.jpeg"
        self.data = data
    }
}
