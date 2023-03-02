//
//  AddRaceViewController.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import UIKit

final class AddRaceViewController: UIViewController {
	private let output: AddRaceViewOutput

    init(output: AddRaceViewOutput) {
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

extension AddRaceViewController: AddRaceViewInput {
}
