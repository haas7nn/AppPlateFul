//
//  NGOReviewItem.swift
//  AppPlateFul
//

import UIKit

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
    
    // Get image from Assets or fallback to system icon
    var logoImage: UIImage? {
        if let assetImage = UIImage(named: logoName) {
            return assetImage
        }
        return UIImage(systemName: "building.2.crop.circle.fill")
    }
    
    // ⚠️ Change logoName values to match YOUR Assets.xcassets names!
    static let sampleData: [NGOReviewItem] = [
        NGOReviewItem(
            id: "1",
            name: "Islamic Hands",
            logoName: "islamichands",  // ← Your asset name
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
            logoName: "salmonda_helps",  // ← Your asset name
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
            logoName: "hope_foundation",  // ← Your asset name
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
