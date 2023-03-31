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

final class UserNetworkManagerImpl: NetworkManager, UserNetworkManager {
    private let router: Router<UserEndPoint>
    
    init(router: Router<UserEndPoint>) {
        self.router = router
    }
    
    func login(email: String, password: String) async -> AuthStatus {
        let result = await router.request(.login(email: email, password: password))
        switch getStatus(response: result.response) {
        case .success:
            let cookies = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
                return cookie.name == ".AspNetCore.Session"
            })?.value ?? ""
            defaults.set(cookies, forKey: "cookie")
            return .authorized(accsessToken: cookies)
        case let .failure(reason):
            return .nonAuthorized(error: reason ?? "")
        }
    }
    
    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: String,
                  sex: Int) async -> RegisterStatus {
        let result = await router.request(.register(surname: surname,
                                                    name: name,
                                                    email: email,
                                                    password: password,
                                                    city: city,
                                                    birthday: birthday,
                                                    sex: sex))
        switch getStatus(response: result.response) {
        case .success:
            let cookies = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
                return cookie.name == ".AspNetCore.Session"
            })?.value ?? ""
            defaults.set(cookies, forKey: "cookie")
            return .authorized(accsessToken: cookies)
        case let .failure(reason):
            return .nonAuthorized(error: reason ?? "")
        }
    }
    
    
    func currentUserInfo() async -> (user: CurrentUser?, error: String?) {
        let result = await router.request(.currentUser)
        if result.error != nil {
            return (nil, "Check connection")
        }
        
        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try JSONDecoder().decode(CurrentUser.self, from: responseData)
                return (apiResponse.self, nil)
            } catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
            
        case let .failure(reason):
            return (nil, reason)
        }
    }
    
    func getUserInfo(id: String) async -> (user: UserInfo?, String?) {
        let result = await router.request(.userInfo(id: id))
        if result.error != nil {
            return (nil, "Check connection")
        }
        
        switch getStatus(response: result.response) {
        case .success:
            guard let responseData = result.data else {
                return (nil, NetworkResponse.noData.rawValue)
            }
            do {
                let apiResponse = try JSONDecoder().decode(UserInfo.self, from: responseData)
                return (apiResponse.self, nil)
            } catch {
                return (nil, NetworkResponse.unableToDecode.rawValue)
            }
            
        case let .failure(reason):
            return (nil, reason)
        }
    }
    
    func logout() {
        //        HTTPCookiePropertyKey(".AspNetCore.Session")
        //        HTTPCookie(properties: [HTTPCookiePropertyKey(".AspNetCore.Session") : "sdfgsdrg"])
        //        HTTPCookieStorage.shared.deleteCookie(HTTPCookie(properties: [HTTPCookiePropertyKey(".AspNetCore.Session") : "sdfgsdrg"]))
        defaults.removeObject(forKey: "cookie")
    }
}
