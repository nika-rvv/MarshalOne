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

    let loginStackView: LoginStackView = {
        let loginSV = LoginStackView()
        loginSV.translatesAutoresizingMaskIntoConstraints = false
        return loginSV
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
        setupConstraints()
	}
}

extension LoginViewController {
    func setupConstraints(){
        view.addSubview(loginStackView)
        loginStackView.centerY()
        loginStackView.leading(43)
        loginStackView.trailing(-43)
    }
}


extension LoginViewController: LoginViewInput {
}
