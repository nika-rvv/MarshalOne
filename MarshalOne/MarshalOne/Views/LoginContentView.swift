//
//  LoginContentView.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//

import UIKit

class LoginContentView: UIView {
    private let loginLabel: UILabel = {
        let loginLa = UILabel()
        loginLa.translatesAutoresizingMaskIntoConstraints = false
        loginLa.text = R.string.localizable.welcomeLabel()
        loginLa.textColor = .mainTextColor
        loginLa.numberOfLines = 0
        loginLa.textAlignment = .center
        loginLa.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return loginLa
    }()
    
    private let loginStackView: UIStackView = {
        let loginSV = UIStackView()
        loginSV.translatesAutoresizingMaskIntoConstraints = false
        loginSV.alignment = .center
        loginSV.axis = .vertical
        loginSV.spacing = 12
        return loginSV
    }()
    
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
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}


extension LoginContentView {
    func setupConstraints() {
        self.addSubview(loginLabel)
        loginLabel.top(isIncludeSafeArea: false)
        loginLabel.leading()
        loginLabel.trailing()
        
        self.addSubview(loginStackView)
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20)
        ])
        loginStackView.leading(43)
        loginStackView.trailing(-43)
        
        loginStackView.addArrangedSubview(mailTextField)
        mailTextField.top(isIncludeSafeArea: false)
        mailTextField.leading()
        mailTextField.trailing()
        mailTextField.height(44)
        
        loginStackView.addArrangedSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 12)
        ])
        passwordTextField.leading()
        passwordTextField.trailing()
        passwordTextField.height(44)
    }
    
    func setupViews() {
        mailTextField.setupPlaceholder(with: R.string.localizable.enterEmail())
        passwordTextField.setupPlaceholder(with: R.string.localizable.enterPassword())
    }
}
