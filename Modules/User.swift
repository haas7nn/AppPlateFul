//
//  User.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 31/12/2025.
//

import Foundation

enum UserRole: String, Codable {
    case donor
    case ngo
    case admin
}

struct User: Codable {
    let id: String
    var displayName: String
    var imageRef: String
    var role: UserRole
}
