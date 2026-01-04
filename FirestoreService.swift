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

    func fetchNGOs(completion: @escaping ([NGOItem]) -> Void) {
        // Works with either:
        // - status: "Approved"
        // - approved: true
        db.collection("ngo_reviews")
            .getDocuments { snap, error in

                if let error = error {
                    print("❌ fetchNGOs:", error.localizedDescription)
                    completion([])
                    return
                }

                let docs = snap?.documents ?? []

                let items: [NGOItem] = docs.compactMap { d in
                    let x = d.data()

                    let status = (x["status"] as? String) ?? ""
                    let approved = (x["approved"] as? Bool) ?? false

                    // keep only approved
                    if status != "Approved" && approved == false {
                        return nil
                    }

                    return NGOItem(
                        id: d.documentID,
                        name: x["name"] as? String ?? "",
                        tagline: x["tagline"] as? String ?? "",
                        city: x["city"] as? String ?? "",
                        category: x["category"] as? String ?? "",
                        imageName: x["imageName"] as? String ?? ""
                    )
                }

                completion(items)
            }
    }

    func setFavorite(userKey: String, ngoId: String, isFav: Bool, completion: @escaping (Error?) -> Void) {
        let ref = db.collection("users").document(userKey).collection("favorites").document(ngoId)

        if isFav {
            ref.setData(["createdAt": Date().timeIntervalSince1970]) { err in
                completion(err)
            }
        } else {
            ref.delete { err in
                completion(err)
            }
        }
    }

    func fetchFavoriteIds(userKey: String, completion: @escaping (Set<String>) -> Void) {
        db.collection("users").document(userKey).collection("favorites")
            .getDocuments { snap, _ in
                let ids = Set((snap?.documents ?? []).map { $0.documentID })
                completion(ids)
            }
    }
}
