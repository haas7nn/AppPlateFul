//
//  Donation.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 22/12/2025.
//

import Foundation

struct Donation: Codable {
    let id: String

    var title: String
    let description: String
    let quantity: String
    var expiryDate: Date?
    let imageRef: String

    var donorId: String
    var donorName: String

    var ngoId: String?
    var status: DonationStatus
    var scheduledPickup: PickupSchedule?
}

extension Donation {

    func toFirestore() -> [String: Any] {
        var data: [String: Any] = [
            "title": title,
            "description": description,
            "quantity": quantity,
            "imageRef": imageRef,
            "donorId": donorId,
            "donorName": donorName,
            "status": status.rawValue
        ]

        data["expiryDate"] = expiryDate as Any
        data["ngoId"] = ngoId as Any

        if let scheduledPickup {
            data["scheduledPickup"] = scheduledPickup.toFirestore()
        }

        return data
    }

    static func fromFirestore(_ data: [String: Any], id: String) -> Donation? {
        guard
            let title = data["title"] as? String,
            let description = data["description"] as? String,
            let quantity = data["quantity"] as? String,
            let imageRef = data["imageRef"] as? String,
            let donorId = data["donorId"] as? String,
            let donorName = data["donorName"] as? String,
            let statusRaw = data["status"] as? String,
            let status = DonationStatus(rawValue: statusRaw)
        else {
            return nil
        }

        let expiryDate = data["expiryDate"] as? Date
        let ngoId = data["ngoId"] as? String

        var pickup: PickupSchedule?
        if let pickupData = data["scheduledPickup"] as? [String: Any] {
            pickup = PickupSchedule.fromFirestore(pickupData)
        }

        return Donation(
            id: id,
            title: title,
            description: description,
            quantity: quantity,
            expiryDate: expiryDate,
            imageRef: imageRef,
            donorId: donorId,
            donorName: donorName,
            ngoId: ngoId,
            status: status,
            scheduledPickup: pickup
        )
    }
}
