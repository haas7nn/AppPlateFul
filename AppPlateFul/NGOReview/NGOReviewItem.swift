//
//  NGOReviewItem.swift
//  AppPlateFul
//

import UIKit
import FirebaseFirestore

struct NGOReviewItem {
    let id: String
    let name: String
    let logoName: String
    let ratingsCount: Int
    let area: String
    let openingHours: String
    let avgPickupTime: String
    let collectedDonations: String
    let pickupReliability: String
    let communityReviews: String
    let status: String = "Pending Verification"

    // ✅ Add back the normal initializer (this fixes your sampleData errors)
    init(
        id: String,
        name: String,
        logoName: String,
        ratingsCount: Int,
        area: String,
        openingHours: String,
        avgPickupTime: String,
        collectedDonations: String,
        pickupReliability: String,
        communityReviews: String
    ) {
        self.id = id
        self.name = name
        self.logoName = logoName
        self.ratingsCount = ratingsCount
        self.area = area
        self.openingHours = openingHours
        self.avgPickupTime = avgPickupTime
        self.collectedDonations = collectedDonations
        self.pickupReliability = pickupReliability
        self.communityReviews = communityReviews
    }

    var logoImage: UIImage? {
        UIImage(named: logoName) ?? UIImage(systemName: "building.2.crop.circle.fill")
    }

    // ✅ Firestore init (optional)
    init?(doc: QueryDocumentSnapshot) {
        let d = doc.data()

        let name = d["name"] as? String ?? ""
        let logoName = d["logoName"] as? String ?? ""

        if name.isEmpty { return nil }

        self.id = doc.documentID
        self.name = name
        self.logoName = logoName
        self.ratingsCount = d["ratingsCount"] as? Int ?? 0
        self.area = d["area"] as? String ?? ""
        self.openingHours = d["openingHours"] as? String ?? ""
        self.avgPickupTime = d["avgPickupTime"] as? String ?? ""
        self.collectedDonations = d["collectedDonations"] as? String ?? ""
        self.pickupReliability = d["pickupReliability"] as? String ?? ""
        self.communityReviews = d["communityReviews"] as? String ?? ""
    }

    func toFirestoreData() -> [String: Any] {
        [
            "name": name,
            "logoName": logoName,
            "ratingsCount": ratingsCount,
            "area": area,
            "openingHours": openingHours,
            "avgPickupTime": avgPickupTime,
            "collectedDonations": collectedDonations,
            "pickupReliability": pickupReliability,
            "communityReviews": communityReviews,
            "createdAt": Date().timeIntervalSince1970
        ]
    }

    static let sampleData: [NGOReviewItem] = [
        NGOReviewItem(
            id: "1",
            name: "Islamic Hands",
            logoName: "islamichands",
            ratingsCount: 122,
            area: "Sadad, Bahrain",
            openingHours: "9:00AM - 9:00PM",
            avgPickupTime: "22 minutes",
            collectedDonations: "16 this month",
            pickupReliability: "100% on-time",
            communityReviews: "N/A"
        ),
        NGOReviewItem(
            id: "2",
            name: "Salmonda Helps",
            logoName: "salmonda_helps",
            ratingsCount: 85,
            area: "Sitra, Bahrain",
            openingHours: "8:00AM - 6:00PM",
            avgPickupTime: "15 minutes",
            collectedDonations: "24 this month",
            pickupReliability: "95% on-time",
            communityReviews: "4.5 stars"
        ),
        NGOReviewItem(
            id: "3",
            name: "Hope Foundation",
            logoName: "hope_foundation",
            ratingsCount: 67,
            area: "Manama, Bahrain",
            openingHours: "10:00AM - 8:00PM",
            avgPickupTime: "30 minutes",
            collectedDonations: "12 this month",
            pickupReliability: "90% on-time",
            communityReviews: "4.0 stars"
        )
    ]
}
