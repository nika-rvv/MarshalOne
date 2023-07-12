//
//  MemberManager.swift
//  MarshalOne
//
//  Created by Veronika on 13.05.2023.
//

import Foundation

protocol MemberManager {
    func postMember(with id: Int) async -> String?
    func deleteMember(with id: Int) async -> String?
    func getMember(with id: Int) async -> (isMember: Bool?, error: String?)
}
