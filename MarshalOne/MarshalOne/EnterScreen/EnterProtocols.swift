//
//  EnterProtocols.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//  
//

import Foundation

protocol EnterModuleInput {
	var moduleOutput: EnterModuleOutput? { get }
}

protocol EnterModuleOutput: AnyObject {
}

protocol EnterViewInput: AnyObject {
}

protocol EnterViewOutput: AnyObject {
    func showNextScreen()
}

protocol EnterInteractorInput: AnyObject {
}

protocol EnterInteractorOutput: AnyObject {
}

protocol EnterRouterInput: AnyObject {
    func timerFinished()
}
