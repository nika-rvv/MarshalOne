//
//  LoginStackView.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//

import Foundation
import UIKit

class LoginStackView: UIView {
    private let mailTextField: CustomTF = {
        let mailTF = CustomTF()
        mailTF.translatesAutoresizingMaskIntoConstraints = false
        return mailTF
    }()
    
    private let passwordTextField: CustomTF = {
        let passwordTF = CustomTF()
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        return passwordTF
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
        self.addSubview(mailTextField)
        mailTextField.top(isIncludeSafeArea: false)
        mailTextField.leading()
        mailTextField.trailing()
        mailTextField.height(42)
        
        self.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 21)
        ])
        passwordTextField.leading()
        passwordTextField.trailing()
        passwordTextField.height(42)
        passwordTextField.setupSecureEntry()
    }
}
