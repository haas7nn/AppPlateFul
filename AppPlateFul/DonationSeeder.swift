//
//  DonationSeeder.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 04/01/2026.
//

import Foundation
import FirebaseFirestore

final class DonationSeeder {

    static let shared = DonationSeeder()
    private init() {}

    private let db = Firestore.firestore()
    private let seedKey = "didSeedDonations_v1"

    func seedIfNeeded() {

        if UserDefaults.standard.bool(forKey: seedKey) {
            return
        }

        db.collection("donations").limit(to: 1).getDocuments { snap, error in
            if error != nil { return }

            let hasData = (snap?.documents.isEmpty == false)
            if hasData {
                UserDefaults.standard.set(true, forKey: self.seedKey)
                return
            }

            self.insertDonations { ok in
                if ok {
                    UserDefaults.standard.set(true, forKey: self.seedKey)
                }
            }
        }
    }

    private func insertDonations(completion: @escaping (Bool) -> Void) {

        let donorId = "donor_1"
        let donorName = "Ahmed Ali"
        let ngoId = "ngo_1"

        let donations: [Donation] = [

            Donation(
                id: "don_1",
                title: "Churros Cups",
                description: "Freshly fried churros served with rich chocolate dipping sauce.",
                quantity: "10 Cups",
                expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 2),
                imageRef: "fork.knife.circle.fill",
                donorId: donorId,
                donorName: donorName,
                ngoId: nil,
                status: .pending,
                scheduledPickup: nil
            ),

            Donation(
                id: "don_2",
                title: "Sandwich Boxes",
                description: "Fresh sandwich boxes with chicken and vegetable fillings.",
                quantity: "5 Boxes",
                expiryDate: Date().addingTimeInterval(60 * 60 * 24),
                imageRef: "takeoutbag.and.cup.and.straw.fill",
                donorId: donorId,
                donorName: donorName,
                ngoId: ngoId,
                status: .accepted,
                scheduledPickup: nil
            ),

            Donation(
                id: "don_3",
                title: "Hot Meals",
                description: "Hot ready-to-serve meals prepared today and packed safely.",
                quantity: "15 Meals",
                expiryDate: Date().addingTimeInterval(60 * 60 * 12),
                imageRef: "flame.circle.fill",
                donorId: donorId,
                donorName: donorName,
                ngoId: ngoId,
                status: .toBeApproved,
                scheduledPickup: PickupSchedule(
                    id: "pickup_1",
                    donationId: "don_3",
                    pickupDate: Date().addingTimeInterval(60 * 60 * 24),
                    pickupTimeRange: "10:00 AM - 12:00 PM",
                    pickupLocation: "Manama"
                )
            ),

            Donation(
                id: "don_4",
                title: "Fruit Boxes",
                description: "Mixed seasonal fruits packed in boxes and ready for pickup.",
                quantity: "8 Boxes",
                expiryDate: Date(),
                imageRef: "leaf.circle.fill",
                donorId: donorId,
                donorName: donorName,
                ngoId: ngoId,
                status: .toBeCollected,
                scheduledPickup: PickupSchedule(
                    id: "pickup_2",
                    donationId: "don_4",
                    pickupDate: Date(),
                    pickupTimeRange: "2:00 PM - 4:00 PM",
                    pickupLocation: "Seef District"
                )
            )
        ]

        let batch = db.batch()

        for donation in donations {
            let ref = db.collection("donations").document(donation.id)
            batch.setData(donation.toFirestore(), forDocument: ref)
        }

        batch.commit { error in
            completion(error == nil)
        }
    }
}
