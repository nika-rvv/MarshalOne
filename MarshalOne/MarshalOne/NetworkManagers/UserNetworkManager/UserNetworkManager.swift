//
//  UserNetworkManager.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation

let defaults = UserDefaults.standard

enum AuthStatus {
    case authorized(accsessToken: String)
    case nonAuthorized(error: String)
}

enum RegisterStatus {
    case authorized(accsessToken: String)
    case nonAuthorized(error: String)
}

protocol UserNetworkManager {
    func login(email: String, password: String) async -> AuthStatus
    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: String,
                  sex: Int) async -> RegisterStatus
    func currentUserInfo() async -> (user: CurrentUser?, error: String?)
    func getUserInfo(id: String) async ->  (user: UserInfo?, String?)
    func logout()
}
