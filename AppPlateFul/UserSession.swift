//
//  UserSession.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 04/01/2026.
//

import Foundation

final class UserSession {

    static let shared = UserSession()
    private init() {}

    var userId: String?
    var role: UserRole?

    var isLoggedIn: Bool {
        return userId != nil && role != nil
    }

    func login(userId: String, role: UserRole) {
        self.userId = userId
        self.role = role
    }

    func logout() {
        userId = nil
        role = nil
    }
}
