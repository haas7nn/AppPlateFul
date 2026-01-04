//
//  DiscoveryNGO.swift
//  AppPlateFul
//

import Foundation
import FirebaseFirestore

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

    // MARK: - Manual Initializer
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

    // MARK: - Firestore Initializer (FIXED)
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        print("🔍 Parsing DiscoveryNGO from doc: \(doc.documentID)")
        print("   Raw data: \(data)")

        // Get name - required field
        guard let name = data["name"] as? String, !name.isEmpty else {
            print("   ❌ No name found, skipping")
            return nil
        }

        self.id = doc.documentID
        self.name = name
        
        // Get verified/approved status
        self.verified = data["approved"] as? Bool ?? false
        
        // Get logo URL
        self.imageURL = data["logoURL"] as? String ?? ""
        
        // Get rating
        self.rating = data["rating"] as? Double ?? 0.0
        
        // Get reviews count
        self.reviews = data["ratingsCount"] as? Int ?? 0
        
        // Get contact info
        self.phone = data["phone"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.address = data["address"] as? String ?? data["area"] as? String ?? ""
        
        // Build short description
        let description = data["description"] as? String ?? ""
        let communityReviews = data["communityReviews"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let area = data["area"] as? String ?? ""
        
        if !description.isEmpty {
            self.desc = description
        } else if !communityReviews.isEmpty {
            self.desc = communityReviews
        } else if !status.isEmpty {
            self.desc = status
        } else if !area.isEmpty {
            self.desc = area
        } else {
            self.desc = "NGO Partner"
        }
        
        // Build full description
        let fullDesc = data["fullDescription"] as? String ?? ""
        let openingHours = data["openingHours"] as? String ?? ""
        let avgPickupTime = data["avgPickupTime"] as? String ?? ""
        let pickupReliability = data["pickupReliability"] as? String ?? ""
        let collectedDonations = data["collectedDonations"] as? String ?? ""
        
        if !fullDesc.isEmpty {
            self.fullDescription = fullDesc
        } else {
            var parts: [String] = []
            if !area.isEmpty { parts.append("📍 Area: \(area)") }
            if !openingHours.isEmpty { parts.append("🕐 Hours: \(openingHours)") }
            if !avgPickupTime.isEmpty { parts.append("⏱ Avg Pickup: \(avgPickupTime)") }
            if !pickupReliability.isEmpty { parts.append("✅ Reliability: \(pickupReliability)") }
            if !collectedDonations.isEmpty { parts.append("📦 Donations: \(collectedDonations)") }
            
            self.fullDescription = parts.isEmpty ? description : parts.joined(separator: "\n")
        }
        
        print("   ✅ Successfully parsed: \(self.name)")
    }
}
