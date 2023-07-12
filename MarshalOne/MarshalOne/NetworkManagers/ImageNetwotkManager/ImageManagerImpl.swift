//
//  ImageManagerImpl.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation
final class ImageManagerImpl: NetworkManager, ImageManager {
    private let router: Router<ImageEndPoint>
    
    init(router: Router<ImageEndPoint>) {
        self.router = router
    }
    
    
    func postImage(with image: Data) async -> (imageData: ImageData?, error: String?) {
        let result = await router.request(.postImage(image: image))


        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try? JSONDecoder().decode(ImageData.self, from: responseData)
                return (apiResponse, nil)
            }
            catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
        case let .failure(reason):
            return (nil, reason)
        }
    }
}
