//
//  UserSeeder.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 04/01/2026.
//

import Foundation
import FirebaseFirestore

final class UsersSeeder {

    static let shared = UsersSeeder()
    private init() {}

    private let db = Firestore.firestore()
    private let seedKey = "didSeedUsers_v1"

    func seedIfNeeded() {

        if UserDefaults.standard.bool(forKey: seedKey) {
            return
        }

        db.collection("users").limit(to: 1).getDocuments { snap, error in
            if error != nil { return }

            let hasData = (snap?.documents.isEmpty == false)
            if hasData {
                UserDefaults.standard.set(true, forKey: self.seedKey)
                return
            }

            self.insertUsers { ok in
                if ok {
                    UserDefaults.standard.set(true, forKey: self.seedKey)
                }
            }
        }
    }

    private func insertUsers(completion: @escaping (Bool) -> Void) {

        let donor = User(
            id: "donor_1",
            displayName: "Ahmed Ali",
            imageRef: "person.circle.fill",
            role: .donor,
            email: "ahmed@example.com",
            phone: "+973 3456 7890",
            status: "Active",
            joinDate: "Jan 15, 2024",
            profileImageName: "person.circle.fill",
            isFavorite: false
        )

        let ngo = User(
            id: "ngo_1",
            displayName: "Helping Hands NGO",
            imageRef: "building.2.fill",
            role: .ngo,
            email: "contact@helpinghands.org",
            phone: "+973 3987 6543",
            status: "Verified",
            joinDate: "Feb 20, 2024",
            profileImageName: "building.2.fill",
            isFavorite: nil
        )

        let users = [donor, ngo]
        let batch = db.batch()

        for user in users {
            let ref = db.collection("users").document(user.id)
            batch.setData(user.toFirestore(), forDocument: ref)
        }

        batch.commit { error in
            completion(error == nil)
        }
    }
}
