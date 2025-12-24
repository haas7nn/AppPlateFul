//
//  User.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

//
//  User.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

struct User {
    var id: String
    var name: String
    var status: String
    var isFavorite: Bool
    var avatarImage: UIImage?
    
    // User Information
    var role: String
    var isVerified: Bool
    
    // Activity Summary
    var donorType: String
    var donationsMade: Int
    var mealsProvided: Int
    var notificationsEnabled: Bool
    
    // Contact Information
    var phone: String
    var email: String
    var address: String
    
    // MARK: - Initializers
    
    /// Simple initializer for list display
    init(name: String, status: String, isFavorite: Bool) {
        self.id = UUID().uuidString
        self.name = name
        self.status = status
        self.isFavorite = isFavorite
        self.avatarImage = nil
        
        // Default values
        self.role = "Donor"
        self.isVerified = true
        self.donorType = "Individual"
        self.donationsMade = 18
        self.mealsProvided = 92
        self.notificationsEnabled = true
        self.phone = "+973 37282388"
        self.email = "\(name.lowercased().replacingOccurrences(of: " ", with: ""))@gmail.com"
        self.address = "Manama, Bahrain"
    }
    
    /// Full initializer with all properties
    init(id: String = UUID().uuidString,
         name: String,
         status: String,
         isFavorite: Bool,
         avatarImage: UIImage? = nil,
         role: String,
         isVerified: Bool,
         donorType: String,
         donationsMade: Int,
         mealsProvided: Int,
         notificationsEnabled: Bool,
         phone: String,
         email: String,
         address: String) {
        
        self.id = id
        self.name = name
        self.status = status
        self.isFavorite = isFavorite
        self.avatarImage = avatarImage
        self.role = role
        self.isVerified = isVerified
        self.donorType = donorType
        self.donationsMade = donationsMade
        self.mealsProvided = mealsProvided
        self.notificationsEnabled = notificationsEnabled
        self.phone = phone
        self.email = email
        self.address = address
    }
}

// MARK: - Sample Data
extension User {
    
    static var sampleUsers: [User] {
        return [
            User(
                name: "Abdulwahid",
                status: "Active",
                isFavorite: true,
                avatarImage: nil,
                role: "Donor",
                isVerified: true,
                donorType: "Individual",
                donationsMade: 18,
                mealsProvided: 92,
                notificationsEnabled: true,
                phone: "+973 37282388",
                email: "abdulwahid@gmail.com",
                address: "Manama, Bahrain"
            ),
            User(
                name: "Zahra Ali",
                status: "Active",
                isFavorite: false,
                avatarImage: nil,
                role: "Volunteer",
                isVerified: true,
                donorType: "Individual",
                donationsMade: 5,
                mealsProvided: 24,
                notificationsEnabled: true,
                phone: "+973 38123456",
                email: "zahra.ali@gmail.com",
                address: "Riffa, Bahrain"
            ),
            User(
                name: "Hussein Mohammed",
                status: "Inactive",
                isFavorite: true,
                avatarImage: nil,
                role: "Donor",
                isVerified: false,
                donorType: "Corporate",
                donationsMade: 42,
                mealsProvided: 230,
                notificationsEnabled: false,
                phone: "+973 39876543",
                email: "hussein.m@gmail.com",
                address: "Muharraq, Bahrain"
            ),
            User(
                name: "Ahmed Ali",
                status: "Active",
                isFavorite: false,
                avatarImage: nil,
                role: "Admin",
                isVerified: true,
                donorType: "Individual",
                donationsMade: 8,
                mealsProvided: 45,
                notificationsEnabled: true,
                phone: "+973 33456789",
                email: "ahmed.ali@gmail.com",
                address: "Saar, Bahrain"
            )
        ]
    }
}
