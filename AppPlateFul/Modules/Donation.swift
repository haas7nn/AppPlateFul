//
//  Donation.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 22/12/2025.
//

import Foundation

struct Donation: Codable {
    let id: String

    var title: String
    let description: String
    let quantity: String
    var expiryDate: Date?
    let imageRef: String

    var donorId: String
    var donorName: String

    var ngoId: String?
    var status: DonationStatus
    var scheduledPickup: PickupSchedule?
}
struct User {
    let id: String
    let displayName: String
    let imageRef: String   // Firebase-safe image reference
}
