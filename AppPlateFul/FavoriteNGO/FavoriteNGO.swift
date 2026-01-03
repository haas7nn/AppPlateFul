//
//  FavoriteNGO.swift
//  AppPlateFul
//
//  202301625 - Samana
//

import Foundation
import FirebaseFirestore

// Model representing a favorite NGO saved by the user
struct FavoriteNGO {

    // MARK: - Properties
    let id: String
    let name: String
    let desc: String
    let fullDescription: String
    let imageName: String
    let rating: Double
    let reviews: Int
    let phone: String
    let email: String
    let address: String

    // MARK: - Firestore Initializer
    // Creates a FavoriteNGO instance from Firestore document data
    init?(doc: DocumentSnapshot) {
        let data = doc.data() ?? [:]

        let name = data["name"] as? String ?? ""
        if name.isEmpty { return nil }

        // Parse rating safely (Double or Int)
        let rating: Double
        if let r = data["rating"] as? Double {
            rating = r
        } else if let r = data["rating"] as? Int {
            rating = Double(r)
        } else {
            rating = 0
        }

        // Parse reviews count safely (Int or Double)
        let reviews: Int
        if let r = data["reviews"] as? Int {
            reviews = r
        } else if let r = data["reviews"] as? Double {
            reviews = Int(r)
        } else {
            reviews = 0
        }

        self.id = doc.documentID
        self.name = name
        self.desc = data["desc"] as? String ?? ""
        self.fullDescription = data["fullDescription"] as? String ?? ""
        self.imageName = data["imageName"] as? String ?? ""
        self.rating = rating
        self.reviews = reviews
        self.phone = data["phone"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.address = data["address"] as? String ?? ""
    }
}
