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
    func didTapCloseViewControllerButton() {
        router.closeViewController()
    }
    
    func didTapAddRace(with raceInfo: [String?]) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(addRaceInfo: raceInfo)
        if emptyFieldsIndexes.isEmpty {
            interactor.addRace(with: raceInfo)
        } else if !emptyFieldsIndexes.isEmpty{
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        }
    }
}

extension AddRacePresenter: AddRaceInteractorOutput {
    func raceAdded() {
        router.closeViewController()
    }
}
