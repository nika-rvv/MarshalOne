//
//  RegisterInteractor.swift
//  MarshalOne
//
//  Created by Veronika on 19.02.2023.
//  
//

import Foundation

final class RegisterInteractor {
	weak var output: RegisterInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(userManager: UserNetworkManager) {
        self.userManager = userManager
    }
}

extension RegisterInteractor: RegisterInteractorInput {
    func registerUser(with info: [String?]) {
        Task {
            let registerInfo = info.compactMap{$0}
            var sex: Int = 0
            if registerInfo[3] == "муж" {
                sex = 1
            } else {
                sex = 2
            }
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert([.withFractionalSeconds,
                                            .withInternetDateTime])
            let dateStr: [String] = registerInfo[2].components(separatedBy: ".")
            guard let date = formatter.date(from: "\(dateStr[2])-\(dateStr[1])-\(dateStr[0])T03:30:00.000Z") else {
                return
            }
            let string = formatter.string(from: date)
            let registerStatus = await userManager.register(surname: registerInfo[1],
                                                              name: registerInfo[0],
                                                              email: registerInfo[5],
                                                              password: registerInfo[6],
                                                              city: registerInfo[4],
                                                              birthday: string,
                                                              sex: sex)
            switch registerStatus {
            case .authorized:
                self.output?.authorized()
            case .nonAuthorized(error: let error):
                self.output?.notAuthorized(withReason: error)
            }
        }
    }
}
