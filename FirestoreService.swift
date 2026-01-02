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
        db.collection("ngos").getDocuments { snap, _ in
            let docs = snap?.documents ?? []
            let items = docs.map { d -> NGOItem in
                let x = d.data()
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
