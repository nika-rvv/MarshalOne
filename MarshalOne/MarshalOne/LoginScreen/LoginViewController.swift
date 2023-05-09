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
    
    private let fields = ["\(R.string.localizable.email()),", R.string.localizable.password()]
    
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
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    
    private let isRemembered: Bool = true
    
    private var contentViewConstraint: CGFloat = 0
    
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
        rememberUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
}

extension LoginViewController {
    
    func setupImageConstraints(){
        let topConstraint = loginImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        heightConstraint = loginImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.3)
        widthConstraint = loginImage.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
        NSLayoutConstraint.activate([topConstraint,
                                     loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     heightConstraint,
                                     widthConstraint])
    }
    
    func setupConstraints(){
        view.addSubview(loginImage)
        setupImageConstraints()
        
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
        enterButton.leading(24)
        enterButton.trailing(-24)
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
        let email = loginContentView.returnTextFromEmailTextField()
        let password = loginContentView.returnTextFromPasswordTextField()

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.enterButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapSignInButton(with: email, and: password)
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
        if loginContentView.frame.origin.y > keyboardFrame.height {
            UIView.animate(withDuration: 0.3){ [weak self] in
                self?.contentViewConstraint = self?.loginContentView.frame.origin.y ?? 0
                self?.loginContentView.frame.origin.y -= keyboardFrame.height - 10
                self?.setupImageForShownKeyboard()
                self?.view.layoutIfNeeded()
            }
        }
    }
    func setupImageForShownKeyboard() {
        heightConstraint.constant = 160
        widthConstraint.constant = 160
        loginImage.layer.cornerRadius = 80
        loginImage.layer.borderColor = R.color.mainBlue()?.cgColor
        loginImage.layer.borderWidth = 1
        loginImage.clipsToBounds = true
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if loginContentView.frame.origin.y < keyboardFrame.height {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.setupImageForDismissedKeyboard()
                self?.loginContentView.frame.origin.y += keyboardFrame.height - 10
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func setupImageForDismissedKeyboard() {
        heightConstraint.constant = view.bounds.height / 2.2
        widthConstraint.constant = view.bounds.width
        loginImage.layer.borderWidth = 0
        loginImage.layer.cornerRadius = 0
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
        loginContentView.startEditingField()
    }
    
    func rememberUser() {
        if isRemembered {
            self.output.isUserRemembered(isRemembered: isRemembered, forKey: "isRemembered")
        }
    }
}


extension LoginViewController: LoginViewInput {
    func showEmptyFields(withIndexes indexes: [Int]){
        var emptyFields = ""
        for index in indexes {
            emptyFields.append("\(fields[index]) ")
            loginContentView.errorWithEmptyFields(for: index)
        }
        let alert = UIAlertController(title: R.string.localizable.ops(),
                                      message: "\(R.string.localizable.chekFields()) \(emptyFields)",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.correct(), style: .default))
        self.present(alert, animated: true)
    }
    
    func showNonAuthorized(with error: String) {
        let alert = UIAlertController(title: R.string.localizable.ops(), message: "\(error)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.correct(), style: .default))
        self.present(alert, animated: true)
    }
}
