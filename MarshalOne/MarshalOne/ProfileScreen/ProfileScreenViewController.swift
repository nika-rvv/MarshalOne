//
//  ProfileScreenViewController.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

final class ProfileScreenViewController: UIViewController {
	private let output: ProfileScreenViewOutput

    init(output: ProfileScreenViewOutput) {
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

extension ProfileScreenViewController: ProfileScreenViewInput {
}
