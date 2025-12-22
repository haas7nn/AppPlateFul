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
    var pickupAddress: String
    var expiryDate: Date?

    var donorId: String
    var donorName: String

    var ngoId: String?
    var status: DonationStatus
    var scheduledPickup: PickupSchedule?
}
