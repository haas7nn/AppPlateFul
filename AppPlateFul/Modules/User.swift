import Foundation

enum UserRole: String, Codable {
    case donor
    case ngo
    case admin
}

struct User: Codable {
    let id: String
    
    // Identity
    var displayName: String
    var imageRef: String?
    var role: UserRole
    
    var email: String?
    var phone: String?
    var status: String?
    var joinDate: String?
    var profileImageName: String?
    var isFavorite: Bool?
    
    // MARK: - Sample
    static var sampleUsers: [User] {
        return [
            User(
                id: "1",
                displayName: "Ahmed Ali",
                imageRef: nil,
                role: .donor,
                email: "ahmed@example.com",
                phone: "+973 3456 7890",
                status: "Active",
                joinDate: "Jan 15, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: false
            ),
            User(
                id: "2",
                displayName: "Fatima Hassan",
                imageRef: nil,
                role: .ngo,
                email: "fatima@example.com",
                phone: "+973 3567 8901",
                status: "Active",
                joinDate: "Feb 20, 2024",
                profileImageName: "person.circle.fill",
                isFavorite: true
            )
        ]
    }
}
