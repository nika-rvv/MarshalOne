//
//  CustomTF.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//

import Foundation
import UIKit

class CustomTF: UIView {
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .cellColor
        tf.font = .systemFont(ofSize: 13)
        tf.layer.borderColor = UIColor.systemGray3.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(textField)
        textField.top(isIncludeSafeArea: false)
        textField.bottom(isIncludeSafeArea: false)
        textField.leading()
        textField.trailing()
    }
}
