//
//  ImageManager.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation
protocol ImageManager {
    func postImage(with image: Data) async -> (imageData: ImageData?, error: String?)
}
