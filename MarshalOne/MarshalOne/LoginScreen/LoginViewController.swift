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
    
    private let loginContentView: LoginContentView = {
        let loginCV = LoginContentView()
        loginCV.translatesAutoresizingMaskIntoConstraints = false
        return loginCV
    }()
    
    private let enterButton: CustomButton = {
        let enterBtn = CustomButton()
        enterBtn.translatesAutoresizingMaskIntoConstraints = false
        return enterBtn
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        self.navigationController?.navigationBar.isHidden = true
        setupConstraints()
        setupViews()
        setupActions()
        setupObserversForKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
}

extension LoginViewController {
    
    func setupBigLoginImageConstraints(){
        view.addSubview(loginImage)
        loginImage.top(isIncludeSafeArea: true)
        loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = false
        loginImage.clipsToBounds = false
        loginImage.layer.cornerRadius = 0
        loginImage.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        loginImage.widthAnchor.constraint(equalToConstant: 160).isActive = false
        loginImage.heightAnchor.constraint(equalToConstant: 160).isActive = false
    }
    
    func setupRoundLognImageConstraints(){
        loginImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = false
        loginImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = false
        loginImage.heightAnchor.constraint(equalToConstant: 350).isActive = false
        loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginImage.widthAnchor.constraint(equalToConstant: 160).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        loginImage.layer.cornerRadius = 80
        loginImage.clipsToBounds = true
    }
    
    func setupConstraints(){
        setupBigLoginImageConstraints()
        
        view.addSubview(loginContentView)
        NSLayoutConstraint.activate([
            loginContentView.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 24)
        ])
        loginContentView.leading()
        loginContentView.trailing()
        loginContentView.height(190)
        
        view.addSubview(enterButton)
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: loginContentView.bottomAnchor, constant: 24)
        ])
        enterButton.leading(44)
        enterButton.trailing(-44)
        enterButton.height(44)
        
        view.addSubview(registrationButton)
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 16)
        ])
        registrationButton.leading(60)
        registrationButton.trailing(-60)
    }
    
    func setupViews(){
        enterButton.setupTitle(with: R.string.localizable.enter())
    }
    
    func setupActions() {
        registrationButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        
        enterButton.addTarget(self, action: #selector(didTapSignButton), for: .touchUpInside)
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
    
    @objc
    private func didTapSignButton() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.enterButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapSignInButton()
                self?.enterButton.alpha = 1
            }
        }
    }
    
    func setupObserversForKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserversForKeyboard(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: self.view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: self.view.window)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        print(keyboardFrame.height)
        print(loginContentView.frame.origin.y)
        if loginContentView.frame.origin.y == 433 {
            UIView.animate(withDuration: 0.3){ [weak self] in
                self?.loginContentView.frame.origin.y = keyboardFrame.height - 10
                self?.setupRoundLognImageConstraints()
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.loginContentView.frame.origin.y = 433
            self?.setupBigLoginImageConstraints()
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension LoginViewController: LoginViewInput {
}
