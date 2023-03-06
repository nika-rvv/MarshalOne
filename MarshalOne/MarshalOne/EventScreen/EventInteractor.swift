//
//  EventInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import Foundation

final class EventInteractor {
	weak var output: EventInteractorOutput?
}

extension EventInteractor: EventInteractorInput {
}
