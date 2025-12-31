//
//  NotificationService.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 31/12/2025.
//

import Foundation
// import FirebaseFirestore

final class NotificationService {

    static let shared = NotificationService()
    private init() {}

    // MARK: - Fetch notifications for a user

    func fetchNotifications(for userId: String, completion: @escaping ([AppNotification]) -> Void) {

        completion([])

        /*
        let db = Firestore.firestore()
        let collection = db.collection("notifications")

        var result: [AppNotification] = []
        let group = DispatchGroup()

        group.enter()
        collection.whereField("userId", isEqualTo: userId).getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                result += docs.compactMap {
                    AppNotification.fromFirestore($0.data(), id: $0.documentID)
                }
            }
            group.leave()
        }

        group.enter()
        collection.whereField("isGlobal", isEqualTo: true).getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                result += docs.compactMap {
                    AppNotification.fromFirestore($0.data(), id: $0.documentID)
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            completion(result.sorted { $0.createdAt > $1.createdAt })
        }
        */
    }

    // MARK: - Event notification (created by app logic)

    func addEventNotification(
        to userId: String,
        title: String,
        message: String
    ) {

        let notification = AppNotification(
            id: UUID().uuidString,
            title: title,
            message: message,
            isAnnouncement: false,
            userId: userId,
            isGlobal: false,
            createdAt: Date()
        )

        /*
        let db = Firestore.firestore()
        db.collection("notifications")
            .document(notification.id)
            .setData(notification.toFirestore())
        */
    }

    // MARK: - Admin global announcement

    func addGlobalAnnouncement(
        title: String,
        message: String
    ) {

        let notification = AppNotification(
            id: UUID().uuidString,
            title: title,
            message: message,
            isAnnouncement: true,
            userId: nil,
            isGlobal: true,
            createdAt: Date()
        )

        /*
        let db = Firestore.firestore()
        db.collection("notifications")
            .document(notification.id)
            .setData(notification.toFirestore())
        */
    }
}

