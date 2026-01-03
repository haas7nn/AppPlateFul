//
//  NGOReviewItem.swift
//  AppPlateFul
//
//  202301686 - Hasan
//

import Foundation
import FirebaseFirestore

// Model representing an NGO review item retrieved from Firestore
struct NGOReviewItem {

    // MARK: - Properties
    let id: String
    let name: String
    let logoURL: String
    let ratingsCount: Int
    let area: String
    let openingHours: String
    let avgPickupTime: String
    let collectedDonations: String
    let pickupReliability: String
    let communityReviews: String
    let status: String
    let approved: Bool
    let createdAt: Double

    // MARK: - Initializer
    // Initializes the model using Firestore document data
    init?(doc: QueryDocumentSnapshot) {
        let d = doc.data()

        let name = d["name"] as? String ?? ""
        if name.isEmpty { return nil }

        self.id = doc.documentID
        self.name = name

        // NGO logo URL stored in Firestore
        self.logoURL = d["logoURL"] as? String ?? ""

        self.ratingsCount = d["ratingsCount"] as? Int ?? 0
        self.area = d["area"] as? String ?? ""
        self.openingHours = d["openingHours"] as? String ?? ""
        self.avgPickupTime = d["avgPickupTime"] as? String ?? ""
        self.collectedDonations = d["collectedDonations"] as? String ?? ""
        self.pickupReliability = d["pickupReliability"] as? String ?? ""
        self.communityReviews = d["communityReviews"] as? String ?? ""
        self.status = d["status"] as? String ?? "Pending Verification"
        self.approved = d["approved"] as? Bool ?? false

        // Timestamp of record creation
        self.createdAt = d["createdAt"] as? Double ?? 0
    }

    // MARK: - Firestore Mapping
    // Converts model data into Firestore-compatible dictionary
    func toFirestoreData(approved: Bool, status: String) -> [String: Any] {
        [
            "name": name,
            "logoURL": logoURL,
            "ratingsCount": ratingsCount,
            "area": area,
            "openingHours": openingHours,
            "avgPickupTime": avgPickupTime,
            "collectedDonations": collectedDonations,
            "pickupReliability": pickupReliability,
            "communityReviews": communityReviews,
            "approved": approved,
            "status": status,
            "createdAt": createdAt == 0
                ? Date().timeIntervalSince1970
                : createdAt
        ]
    }
}
