//
//  RegisterViewController.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import UIKit

final class RegisterViewController: UIViewController {
	private let output: RegisterViewOutput

    let fields = [R.string.localizable.name(),
                  R.string.localizable.surname(),
                  R.string.localizable.birthdate(),
                  R.string.localizable.sex(),
                  R.string.localizable.city(),
                  R.string.localizable.email(),
                  R.string.localizable.password(),
                  R.string.localizable.passwordConfirmation()]
    
    private let backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(R.image.backButton(), for: .normal)
        back.clipsToBounds = true
        back.tintColor = R.color.mainBlue()
        back.isEnabled = true
        return back
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    private let regContentView = RegistrationContentView()
    
    private var registrationScrollViewConstraint: NSLayoutConstraint?
    
    
    init(output: RegisterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .screenColor
        addViews()
        setupLayout()
        setupBindings()
        setupBackButton()
        setupObserversForKeyboard()
        setupGestureRecognizer()
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let widthFrame = scrollView.frame.width
        let height = regContentView.frame.height
        scrollView.contentSize = CGSize(width: widthFrame,
                                        height: height)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = contentInset
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = contentInset
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func backButtonTapped(){
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.backButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.backButtonAction()
                self?.backButton.alpha = 1
            }
        }
    }
}

extension RegisterViewController: UIGestureRecognizerDelegate {
    func setupLayout() {
        regContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            regContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            regContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            regContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            regContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            regContentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            regContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 70),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        registrationScrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }
    
    func setupBindings() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        setupAction()
    }
    
    func setupAction(){
        regContentView.setRegisterAction { [weak self] _ in
            UIView.animate(withDuration: 0.3) {
                self?.regContentView.registrationButton.alpha = 0.7
            } completion: { [weak self] finished in
                if finished {
                    self?.output.didTapEnterButton()
                    self?.regContentView.registrationButton.alpha = 1
                }
            }
        }
    }
    
    func setupBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupGestureRecognizer(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(regContentView)
        scrollView.addSubview(backButton)
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
}

extension RegisterViewController: RegisterViewInput {
}
