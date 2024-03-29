//
//  AddRacePresenter.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import Foundation

final class AddRacePresenter {
	weak var view: AddRaceViewInput?
    weak var moduleOutput: AddRaceModuleOutput?
    
	private let router: AddRaceRouterInput
	private let interactor: AddRaceInteractorInput
    
    init(router: AddRaceRouterInput, interactor: AddRaceInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func getIndexesOfEmptyFields(addRaceInfo: [String?]) -> [Int] {
        var result = [Int]()
        for (index, info) in addRaceInfo.enumerated() {
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
}

extension AddRacePresenter: AddRaceModuleInput {
}

extension AddRacePresenter: AddRaceViewOutput {
    func didTapAddRace(with raceInfo: [String?], and imageData: Data?) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(addRaceInfo: raceInfo)
        if emptyFieldsIndexes.isEmpty {
            interactor.addRace(with: raceInfo, and: imageData)
        } else if !emptyFieldsIndexes.isEmpty{
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        }
    }
    
    func didTapCloseViewControllerButton() {
        router.closeViewController()
    }
}

extension AddRacePresenter: AddRaceInteractorOutput {
    func showEror(with error: String) {
        view?.showError(with: error)
    }
    
    func raceAdded() {
        router.closeViewController()
    }
}
