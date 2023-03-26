//
//  RegisterPresenter.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?
    weak var moduleOutput: RegisterModuleOutput?
    
	private let router: RegisterRouterInput
	private let interactor: RegisterInteractorInput
    
    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func getIndexesOfEmptyFields(registerInfo: [String?]) -> [Int] {
        var result = [Int]()
        for (index, info) in registerInfo.enumerated() {
            guard let info = info else {
                result.append(index)
                continue
            }
            if info.isEmpty {
                result.append(index)
            }
        }
        return result
    }
    
    func checkPassword(registerInfo: [String?]) -> Bool {
        if registerInfo[6] == registerInfo[7] {
            return true
        } else {
            return false
        }
    }
}

extension RegisterPresenter: RegisterModuleInput {
}

extension RegisterPresenter: RegisterViewOutput {
    func didTapEnterButton(regInfo: [String?]) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(registerInfo: regInfo)
        if emptyFieldsIndexes.isEmpty && checkPassword(registerInfo: regInfo) {
            interactor.registerUser(with: regInfo)
        } else if !emptyFieldsIndexes.isEmpty{
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        } else if !checkPassword(registerInfo: regInfo){
            view?.showCheckedPassword()
        }
    }
    
    func backButtonAction() {
        router.backButtonTapped()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func notAuthorized(withReason reason: String) {
        print(reason)
    }
    
    func authorized() {
        router.openMainFlow()
    }
}
