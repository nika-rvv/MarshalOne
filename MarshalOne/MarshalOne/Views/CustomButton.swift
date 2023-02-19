//
//  CustomButton.swift
//  MarshalOne
//
//  Created by Veronika on 16.02.2023.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration = .filled()
        self.tintColor = .mainBlueColor
        self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return outgoing
        }
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupTitle(with text: String) {
        self.setTitle(text, for: .normal)
    }
}
