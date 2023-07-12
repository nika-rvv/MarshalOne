//
//  ImageExtension.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//

import UIKit
import Kingfisher

final class KingfisherImage: UIImageView {
    enum DefaultPlaceHolder {
        case event
    }
    
    private let cache = NSCache<NSString, UIImage>()
    private var urlString: String?
    private let placeHolderType: DefaultPlaceHolder
    
    init(placeHolderType: DefaultPlaceHolder) {
        self.placeHolderType = placeHolderType
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: getDefaultPlaceholder(), options: [.cacheMemoryOnly])
    }
    
    func setDefaultImage() {
        image = getDefaultPlaceholder()
    }
    
    private func getDefaultPlaceholder() -> UIImage? {
        switch placeHolderType {
        case .event:
            return R.image.loginImage()
        }
    }
}


