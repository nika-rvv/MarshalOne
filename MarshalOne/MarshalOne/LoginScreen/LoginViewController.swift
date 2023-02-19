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

    private let loginImage: UIImageView = {
        let loginIm = UIImageView()
        loginIm.translatesAutoresizingMaskIntoConstraints = false
        loginIm.image = .loginImage
        return loginIm
    }()
    
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
    
    private let enterButton: CustomButton = {
        let enterBtn = CustomButton()
        enterBtn.translatesAutoresizingMaskIntoConstraints = false
        return enterBtn
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        var attrString0 = NSMutableAttributedString(string: R.string.localizable.noAccount(),
                                                    attributes:[
                                                        .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                                                        .foregroundColor: UIColor.tfText ?? .systemGray])
        let attrString1 = NSAttributedString(string: R.string.localizable.register(),
                                             attributes:[
                                                .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                                                .foregroundColor: UIColor.mainBlueColor ?? .systemBlue])
        attrString0.append(attrString1)
        button.setAttributedTitle(attrString0, for: .normal)
        return button
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
        view.backgroundColor = .screenColor
        setupConstraints()
        setupViews()
        setupActions()
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
        mailTextField.height(44)
        
        loginStackView.addArrangedSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 12)
        ])
        passwordTextField.leading()
        passwordTextField.trailing()
        passwordTextField.height(44)
        
        view.addSubview(enterButton)
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 24)
        ])
        enterButton.leading(44)
        enterButton.trailing(-44)
        enterButton.height(44)
        
        view.addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 16)
        ])
        registrationButton.leading(60)
        registrationButton.trailing(-60)
    }
    
    func setupViews(){
        mailTextField.setupPlaceholder(with: R.string.localizable.enterEmail())
        passwordTextField.setupPlaceholder(with: R.string.localizable.enterPassword())
        enterButton.setupTitle(with: R.string.localizable.enter())
    }
    
    func setupActions() {
        registrationButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapRegButton() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.registrationButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapRegButton()
                self?.registrationButton.alpha = 1
            }
        }
    }
}


extension LoginViewController: LoginViewInput {
}
