//
//  LoginViewController.swift
//  MarshalOne
//
//  Created by Veronika on 10.02.2023.
//  
//

import UIKit

final class LoginViewController: UIViewController {
	private let output: LoginViewOutput

    let loginImage: UIImageView = {
        let loginIm = UIImageView()
        loginIm.translatesAutoresizingMaskIntoConstraints = false
        loginIm.image = .loginImage
        return loginIm
    }()
    
    let loginLabel: UILabel = {
        let loginLa = UILabel()
        loginLa.translatesAutoresizingMaskIntoConstraints = false
        loginLa.text = "Добро пожаловать \nв MarshalOne"
        loginLa.textColor = .mainTextColor
        loginLa.numberOfLines = 0
        loginLa.textAlignment = .center
        loginLa.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return loginLa
    }()
    
    let loginStackView: UIStackView = {
        let loginSV = UIStackView()
        loginSV.translatesAutoresizingMaskIntoConstraints = false
        loginSV.alignment = .center
        loginSV.axis = .vertical
        loginSV.spacing = 12
        return loginSV
    }()
    
    let mailTextField: CustomTF = {
        let mailTF = CustomTF()
        mailTF.translatesAutoresizingMaskIntoConstraints = false
        return mailTF
    }()
    
    let passwordTextField: CustomTF = {
        let passwordTF = CustomTF()
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        return passwordTF
    }()
    
    init(output: LoginViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .ScreenColor
        setupConstraints()
	}
}

extension LoginViewController {
    func setupConstraints(){
        view.addSubview(loginImage)
        loginImage.top(isIncludeSafeArea: true)
        loginImage.leading()
        loginImage.trailing()
        
        view.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 8)
        ])
        loginLabel.leading()
        loginLabel.trailing()
        
        view.addSubview(loginStackView)
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20)
        ])
        loginStackView.leading(43)
        loginStackView.trailing(-43)
        
        loginStackView.addArrangedSubview(mailTextField)
        mailTextField.top(isIncludeSafeArea: false)
        mailTextField.leading()
        mailTextField.trailing()
        loginStackView.addArrangedSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 12)
        ])
        passwordTextField.leading()
        passwordTextField.trailing()
    }
}


extension LoginViewController: LoginViewInput {
}
