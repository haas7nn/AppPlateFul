//
//  FirestoreService.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 02/01/2026.
//

import Foundation
import FirebaseFirestore

struct NGOItem {
    let id: String
    let name: String
    let tagline: String
    let city: String
    let category: String
    let imageName: String
}

final class FirestoreService {
    static let shared = FirestoreService()
    private init() {}

    private let db = Firestore.firestore()

    func fetchNGOs(completion: @escaping ([NGO]) -> Void) {
        db.collection("ngo_reviews")
            .whereField("status", isEqualTo: "Approved")
            .getDocuments { snap, error in

                if let error = error {
                    print("❌ fetchNGOs:", error.localizedDescription)
                    completion([])
                    return
                }

                let docs = snap?.documents ?? []

                let ngos = docs.map { d -> NGO in
                    let x = d.data()

                    let ratingsCount = x["ratingsCount"] as? Int ?? 0
                    let rating = min(5.0, max(0.0, Double(ratingsCount) / 200.0))

                    return NGO(
                        id: d.documentID,
                        name: x["name"] as? String ?? "",
                        desc: x["desc"] as? String ?? (x["communityReviews"] as? String ?? ""),
                        fullDescription: x["fullDescription"] as? String ?? "",
                        area: x["area"] as? String ?? "",
                        rating: rating,
                        reviews: ratingsCount,
                        logoURL: x["logoURL"] as? String ?? "",
                        phone: x["phone"] as? String ?? "",
                        email: x["email"] as? String ?? "",
                        address: x["address"] as? String ?? (x["area"] as? String ?? ""),
                        verified: (x["status"] as? String ?? "") == "Approved"
                    )
                }

                completion(ngos)
            }
    }




    func setFavorite(userKey: String, ngoId: String, isFav: Bool, completion: @escaping (Error?) -> Void) {
        let ref = db.collection("users").document(userKey).collection("favorites").document(ngoId)
        if isFav {
            ref.setData(["createdAt": Date().timeIntervalSince1970]) { completion($0) }
        } else {
            ref.delete { completion($0) }
        }
    }

    func fetchFavoriteIds(userKey: String, completion: @escaping (Set<String>) -> Void) {
        db.collection("users").document(userKey).collection("favorites").getDocuments { snap, _ in
            let ids = Set((snap?.documents ?? []).map { $0.documentID })
            completion(ids)
        }
    }
}
