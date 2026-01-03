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

import Foundation

struct User {
    let id: String
    var name: String
    var email: String
    var phone: String
    var role: String
    var status: String
    var joinDate: String
    var profileImageName: String
    var isFavorite: Bool
    
    static var sampleUsers: [User] {
        return [
            User(
                id: "1",
                name: "Ahmed Ali",
                email: "ahmed@example.com",
                phone: "+973 3456 7890",
                role: "Donor",
                status: "Active",
                joinDate: "Jan 15, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: false
            ),
            User(
                id: "2",
                name: "Fatima Hassan",
                email: "fatima@example.com",
                phone: "+973 3567 8901",
                role: "NGO Manager",
                status: "Active",
                joinDate: "Feb 20, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: true
            ),
            User(
                id: "3",
                name: "Mohammed Khalid",
                email: "mohammed@example.com",
                phone: "+973 3678 9012",
                role: "Donor",
                status: "Inactive",
                joinDate: "Mar 10, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: false
            ),
            User(
                id: "4",
                name: "Sara Ahmed",
                email: "sara@example.com",
                phone: "+973 3789 0123",
                role: "Volunteer",
                status: "Active",
                joinDate: "Apr 5, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: false
            )
        ]
    }
}
