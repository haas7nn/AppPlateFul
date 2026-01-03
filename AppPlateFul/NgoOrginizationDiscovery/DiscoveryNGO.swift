//
//  DiscoveryNGO.swift
//  AppPlateFul
//
//  202301625 - Samana
//

import Foundation
import FirebaseFirestore

// Model representing an NGO displayed in the discovery feature
struct DiscoveryNGO {

    // MARK: - Properties
    let id: String
    let name: String
    let desc: String
    let fullDescription: String
    let verified: Bool
    let imageURL: String
    let rating: Double
    let reviews: Int
    let phone: String
    let email: String
    let address: String

    // MARK: - Initializer
    // Manual initializer
    init(
        id: String,
        name: String,
        desc: String,
        fullDescription: String,
        verified: Bool,
        imageURL: String,
        rating: Double,
        reviews: Int,
        phone: String,
        email: String,
        address: String
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.fullDescription = fullDescription
        self.verified = verified
        self.imageURL = imageURL
        self.rating = rating
        self.reviews = reviews
        self.phone = phone
        self.email = email
        self.address = address
    }

    // MARK: - Firestore Initializer
    // Creates a DiscoveryNGO instance from Firestore document data
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()

        let name = data["name"] as? String ?? ""
        if name.isEmpty { return nil }

        let approved = data["approved"] as? Bool ?? false
        let area = data["area"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let communityReviews = data["communityReviews"] as? String ?? ""
        let openingHours = data["openingHours"] as? String ?? ""
        let avgPickupTime = data["avgPickupTime"] as? String ?? ""
        let pickupReliability = data["pickupReliability"] as? String ?? ""
        let collectedDonations = data["collectedDonations"] as? String ?? ""
        let ratingsCount = data["ratingsCount"] as? Int ?? 0
        let logoURL = data["logoURL"] as? String ?? ""

        // Generates a short description for list display
        let shortDesc: String = {
            if !communityReviews.isEmpty { return communityReviews }
            if !status.isEmpty { return status }
            if !area.isEmpty { return area }
            return "NGO"
        }()

        // Detailed description for profile view
        let longDesc = """
        Area: \(area)
        Hours: \(openingHours)
        Avg pickup: \(avgPickupTime)
        Reliability: \(pickupReliability)
        Donations: \(collectedDonations)
        """

        self.init(
            id: doc.documentID,
            name: name,
            desc: shortDesc,
            fullDescription: longDesc,
            verified: approved,
            imageURL: logoURL,
            rating: 0.0,
            reviews: ratingsCount,
            phone: "",
            email: "",
            address: area
        )
    }
}
