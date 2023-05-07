//
//  RaceInfo.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import Foundation

struct RaceInfo: Hashable {
    let id: Int
    let title: String
    let dateSubtitle: String
    let placeName: String
    let imageId: String
    var numberOfLikes: Int
    var numberOfParticipants: Int
    var numberOfWatchers: Int
    var isLiked: Bool
}

