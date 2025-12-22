//
//  DonationService.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 22/12/2025.
//

import Foundation

final class DonationService {

    /// Shared instance used across the app
    static let shared = DonationService()

    private init() {}

    /// Fetch all donations that are available for NGOs (e.g. pending / accepted)
    /// Later: This will query Firestore and map documents to `Donation` objects
    func fetchAvailableDonations(completion: @escaping ([Donation]) -> Void) {
        completion([])
    }

    /// Fetch a single donation by its ID
    /// Later: This will read a document from Firestore
    func fetchDonation(byId id: String, completion: @escaping (Donation?) -> Void) {
        completion(nil)
    }

    /// Schedule a pickup for a donation
    /// Later: This will write pickup date, time range, and location to Firestore
    /// and update the donation status to `.scheduled`
    func schedulePickup(
        donationId: String,
        schedule: PickupSchedule,
        completion: @escaping (Bool) -> Void
    ) {
        completion(false)
    }

    /// Update only the donation status
    /// Later: This will update the `status` field in Firestore
    func updateDonationStatus(
        donationId: String,
        status: DonationStatus,
        completion: @escaping (Bool) -> Void
    ) {
        completion(false)
    }
}
