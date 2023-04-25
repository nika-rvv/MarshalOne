//
//  LikeManager.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import Foundation

protocol LikeManager {
    func postLike(with id: Int) async -> String?
    func deleteLike(with id: Int) async -> String?
}
