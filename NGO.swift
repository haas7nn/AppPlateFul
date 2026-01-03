//
//  NGO.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

struct NGO {
    var id: String
    var name: String
    var status: VerificationStatus
    var logoImage: UIImage?
    
    // Detail Information
    var area: String
    var openingHours: String
    var averagePickupTime: String
    var collectedDonations: String
    var pickupReliability: String
    var communityReviews: String
    var ratingsCount: Int
    
    enum VerificationStatus: String {
        case pending = "Pending Verification"
        case approved = "Approved"
        case rejected = "Rejected"
        
        var color: UIColor {
            switch self {
            case .pending:
                return .systemOrange
            case .approved:
                return .systemGreen
            case .rejected:
                return .systemRed
            }
        }
    }
    
    // MARK: - Initializers
    init(id: String = UUID().uuidString,
         name: String,
         status: VerificationStatus = .pending,
         logoImage: UIImage? = nil,
         area: String,
         openingHours: String,
         averagePickupTime: String,
         collectedDonations: String,
         pickupReliability: String,
         communityReviews: String,
         ratingsCount: Int) {
        
        self.id = id
        self.name = name
        self.status = status
        self.logoImage = logoImage
        self.area = area
        self.openingHours = openingHours
        self.averagePickupTime = averagePickupTime
        self.collectedDonations = collectedDonations
        self.pickupReliability = pickupReliability
        self.communityReviews = communityReviews
        self.ratingsCount = ratingsCount
    }
}

// MARK: - Sample Data
extension NGO {
    
    static var sampleNGOs: [NGO] {
        return [
            NGO(
                name: "Islamic Hands",
                status: .pending,
                area: "Sitra, Bahrain",
                openingHours: "9:00AM - 9:00PM",
                averagePickupTime: "22 minutes",
                collectedDonations: "16 this month",
                pickupReliability: "100% on-time",
                communityReviews: "N/A",
                ratingsCount: 122
            ),
            NGO(
                name: "Salmonda Helps",
                status: .pending,
                area: "Manama, Bahrain",
                openingHours: "8:00AM - 6:00PM",
                averagePickupTime: "35 minutes",
                collectedDonations: "8 this month",
                pickupReliability: "92% on-time",
                communityReviews: "4.2 stars",
                ratingsCount: 45
            ),
            NGO(
                name: "Helping Hands BH",
                status: .pending,
                area: "Riffa, Bahrain",
                openingHours: "10:00AM - 8:00PM",
                averagePickupTime: "18 minutes",
                collectedDonations: "24 this month",
                pickupReliability: "98% on-time",
                communityReviews: "4.8 stars",
                ratingsCount: 89
            ),
            NGO(
                name: "Food For All",
                status: .pending,
                area: "Muharraq, Bahrain",
                openingHours: "7:00AM - 10:00PM",
                averagePickupTime: "28 minutes",
                collectedDonations: "32 this month",
                pickupReliability: "95% on-time",
                communityReviews: "4.5 stars",
                ratingsCount: 156
            )
        ]
    }
}
