//
//  NotificationSeeder.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 04/01/2026.
//

import Foundation
import FirebaseFirestore

final class NotificationSeeder {

    static let shared = NotificationSeeder()
    private init() {}

    private let db = Firestore.firestore()
    private let seedKey = "didSeedNotifications_v1"

    func seedIfNeeded() {

        if UserDefaults.standard.bool(forKey: seedKey) {
            return
        }

        db.collection("notifications").limit(to: 1).getDocuments { snap, error in
            if error != nil { return }

            let hasData = (snap?.documents.isEmpty == false)
            if hasData {
                UserDefaults.standard.set(true, forKey: self.seedKey)
                return
            }

            self.insertNotifications { ok in
                if ok {
                    UserDefaults.standard.set(true, forKey: self.seedKey)
                }
            }
        }
    }

    private func insertNotifications(completion: @escaping (Bool) -> Void) {

        let donorId = "donor_1"
        let ngoId = "ngo_1"

        let items: [[String: Any]] = [

            [
                "title": "Welcome",
                "message": "Thanks for joining Plateful. You can now create and track donations.",
                "isAnnouncement": false,
                "userId": donorId,
                "isGlobal": false,
                "createdAt": Timestamp(date: Date().addingTimeInterval(-60 * 20))
            ],
            [
                "title": "Donation Accepted",
                "message": "An NGO accepted your donation. Please schedule a pickup time.",
                "isAnnouncement": false,
                "userId": donorId,
                "isGlobal": false,
                "createdAt": Timestamp(date: Date().addingTimeInterval(-60 * 60 * 2))
            ],

            [
                "title": "Welcome",
                "message": "Your NGO account is ready. You can now accept available donations.",
                "isAnnouncement": false,
                "userId": ngoId,
                "isGlobal": false,
                "createdAt": Timestamp(date: Date().addingTimeInterval(-60 * 10))
            ],
            [
                "title": "Pickup Scheduled",
                "message": "A donor scheduled a pickup time. Please review and approve it.",
                "isAnnouncement": false,
                "userId": ngoId,
                "isGlobal": false,
                "createdAt": Timestamp(date: Date().addingTimeInterval(-60 * 60))
            ],

            [
                "title": "System Update",
                "message": "New features added: pickup scheduling and donation tracking.",
                "isAnnouncement": true,
                "userId": NSNull(),
                "isGlobal": true,
                "createdAt": Timestamp(date: Date().addingTimeInterval(-60 * 60 * 24))
            ]
        ]

        let batch = db.batch()

        for data in items {
            let ref = db.collection("notifications").document()
            batch.setData(data, forDocument: ref)
        }

        batch.commit { error in
            completion(error == nil)
        }
    }
}
