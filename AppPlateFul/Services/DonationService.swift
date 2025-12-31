//
//  DonationService.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 22/12/2025.
//

import Foundation

// import FirebaseFirestore

final class DonationService {

    static let shared = DonationService()
    private init() {}

    func fetchAll(completion: @escaping ([Donation]) -> Void) {
        completion([])

        /*
        let db = Firestore.firestore()
        db.collection("donations").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else {
                completion([])
                return
            }
            let items = docs.compactMap { Donation.fromFirestore($0.data(), id: $0.documentID) }
            completion(items)
        }
        */
    }

    func fetchByStatus(_ status: DonationStatus, completion: @escaping ([Donation]) -> Void) {
        completion([])

        /*
        let db = Firestore.firestore()
        db.collection("donations")
            .whereField("status", isEqualTo: status.rawValue)
            .getDocuments { snapshot, error in
                guard let docs = snapshot?.documents else {
                    completion([])
                    return
                }
                let items = docs.compactMap { Donation.fromFirestore($0.data(), id: $0.documentID) }
                completion(items)
            }
        */
    }

    func createDonation(_ donation: Donation, completion: ((Bool) -> Void)? = nil) {
        completion?(false)

        /*
        let db = Firestore.firestore()
        db.collection("donations")
            .document(donation.id)
            .setData(donation.toFirestore()) { error in
                completion?(error == nil)
            }
        */
    }

    func updateStatus(donationId: String, status: DonationStatus, completion: ((Bool) -> Void)? = nil) {
        completion?(false)

        /*
        let db = Firestore.firestore()
        db.collection("donations")
            .document(donationId)
            .updateData(["status": status.rawValue]) { error in
                completion?(error == nil)
            }
        */
    }

    func attachPickupSchedule(donationId: String, pickup: PickupSchedule, completion: ((Bool) -> Void)? = nil) {
        completion?(false)

        /*
        let db = Firestore.firestore()
        db.collection("donations")
            .document(donationId)
            .updateData([
                "scheduledPickup": pickup.toFirestore(),
                "status": DonationStatus.toBeApproved.rawValue
            ]) { error in
                completion?(error == nil)
            }
        */
    }
}
