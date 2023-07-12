//
//  ErrorModel.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation

struct ErrorModel {
    let message: String
}
extension ErrorModel {
    enum errorCodingKeys: String, CodingKey {
        case message = "Message"
    }
}
