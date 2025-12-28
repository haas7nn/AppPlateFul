//
//  dummyDataStore.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 28/12/2025.
//

import Foundation

final class DummyDataStore {

    // MARK: - Users
    static let users: [User] = [
        User(
            id: "user_1",
            displayName: "Chocologi Cafe",
            imageRef: "cup.and.saucer.fill"
        ),
        User(
            id: "user_2",
            displayName: "It's Just Wings",
            imageRef: "takeoutbag.and.cup.and.straw.fill"
        )
    ]

    // MARK: - Donations
    static var donations: [Donation] = [

        // 1️⃣ Pending (Available tab)
        Donation(
            id: "don_1",
            title: "Churros Cups",
            description: "Fresh churros cups with chocolate dip.",
            quantity: "10 Cups",
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 2),
            imageRef: "fork.knife.circle.fill",
            donorId: "user_1",
            donorName: "Chocologi Cafe",
            ngoId: nil,
            status: .pending,
            scheduledPickup: nil
        ),

        // 2️⃣ Accepted (To be scheduled)
        Donation(
            id: "don_2",
            title: "Wings Meals",
            description: "20 meals of assorted wings with drinks.",
            quantity: "20 Meals",
            expiryDate: Date().addingTimeInterval(60 * 60 * 24),
            imageRef: "flame.circle.fill",
            donorId: "user_2",
            donorName: "It's Just Wings",
            ngoId: "ngo_1",
            status: .accepted,
            scheduledPickup: nil
        ),

        // 3️⃣ To be approved (Pickup proposed)
        Donation(
            id: "don_3",
            title: "Sandwich Boxes",
            description: "Freshly prepared sandwich boxes.",
            quantity: "5 Boxes",
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 3),
            imageRef: "takeoutbag.and.cup.and.straw.fill",
            donorId: "user_1",
            donorName: "Chocologi Cafe",
            ngoId: "ngo_1",
            status: .toBeApproved,
            scheduledPickup: PickupSchedule(
                id: "pickup_1",
                donationId: "don_3",
                pickupDate: Date().addingTimeInterval(60 * 60 * 24),
                pickupTimeRange: "10:00 AM - 12:00 PM",
                pickupLocation: "Seef, Bahrain"
            )
        ),

        // 4️⃣ To be collected (Approved pickup)
        Donation(
            id: "don_4",
            title: "Hot Meals",
            description: "Ready-to-serve hot meals.",
            quantity: "15 Meals",
            expiryDate: Date().addingTimeInterval(60 * 60 * 12),
            imageRef: "fork.knife",
            donorId: "user_2",
            donorName: "It's Just Wings",
            ngoId: "ngo_1",
            status: .toBeCollected,
            scheduledPickup: PickupSchedule(
                id: "pickup_2",
                donationId: "don_4",
                pickupDate: Date(),
                pickupTimeRange: "2:00 PM - 4:00 PM",
                pickupLocation: "Manama"
            )
        )
    ]

    // MARK: - Helpers (use these in VCs)

    static func user(by id: String) -> User? {
        users.first { $0.id == id }
    }

    static func donations(with status: DonationStatus) -> [Donation] {
        donations.filter { $0.status == status }
    }

    static func pickup(for donation: Donation) -> PickupSchedule? {
        donation.scheduledPickup
    }
}
