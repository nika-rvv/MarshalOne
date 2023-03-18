//
//  CustomTF.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//

import UIKit

class CustomTF: UIView {
    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .tfColor
        tf.font = .systemFont(ofSize: 13)
        tf.textColor = R.color.mainTextColor()
        tf.layer.borderColor = UIColor.tfText?.cgColor
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
    
    func setupPlaceholder(with text: String) {
        textField.placeholder = text
    }
    
    func setupSecureEntry(){
        textField.isSecureTextEntry = true
    }
    
    func setupInputView(with inputView: UIView?) {
        textField.inputView = inputView
    }
    
    func setupText(with text: String) {
        textField.text = text
    }
}


