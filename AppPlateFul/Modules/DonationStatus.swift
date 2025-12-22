//
//  DonationStatus.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 22/12/2025.
//

import Foundation

enum DonationStatus: String, Codable {
    case pending
    case accepted
    case scheduled
    case completed
    case cancelled
}
