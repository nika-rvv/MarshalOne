//
//  WatcherManager.swift
//  MarshalOne
//
//  Created by Veronika on 07.05.2023.
//

import Foundation

protocol WatcherManager {
    func postView(with id: Int) async -> String?
}
