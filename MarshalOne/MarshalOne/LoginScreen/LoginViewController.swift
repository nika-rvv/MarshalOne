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

    init(output: LoginViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LoginViewController: LoginViewInput {
}
