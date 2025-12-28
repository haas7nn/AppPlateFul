//
//  AcceptedViewController.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 28/12/2025.
//

import UIKit

class AcceptedViewController: UIViewController {
    
    var donation: Donation!

        override func viewDidLoad() {
            super.viewDidLoad()

            title = "Donation Details"

            // Fill UI (no styling)
            donator.text = donation.donorName
            donationDesc.text = donation.description
            qty.text = donation.quantity
            icon.image = UIImage(systemName: donation.imageRef)

            if let expiry = donation.expiryDate {
                exp.text = DateFormatter.dmy.string(from: expiry)
            } else {
                exp.text = "N/A"
            }

            // Optional: change button title based on status (no styling)
            acceptDonationbtn.setTitle(primaryButtonTitle(for: donation.status), for: .normal)
        }

        private func primaryButtonTitle(for status: DonationStatus) -> String {
            switch status {
            case .pending:
                return "Accept Donation"
            case .accepted:
                return "Schedule Pickup"
            case .toBeApproved:
                return "Approve Pickup Time"
            case .toBeCollected:
                return "Mark as Collected"
            default:
                return "OK"
            }
        }

        @IBAction func acceptDonationTapped(_ sender: Any) {

            // ✅ Later you’ll replace with Firebase logic.
            // For now we update dummy store so screens change.

            guard let index = DummyDataStore.donations.firstIndex(where: { $0.id == donation.id }) else { return }

            switch donation.status {

            case .pending:
                // Accept donation -> becomes accepted
                DummyDataStore.donations[index].status = .accepted
                donation.status = .accepted

            case .accepted:
                // For now: no schedule screen yet, just simulate moving to toBeApproved
                DummyDataStore.donations[index].status = .toBeApproved
                donation.status = .toBeApproved

            case .toBeApproved:
                // Approve -> becomes toBeCollected
                DummyDataStore.donations[index].status = .toBeCollected
                donation.status = .toBeCollected

            case .toBeCollected:
                // Mark collected -> becomes completed
                DummyDataStore.donations[index].status = .completed
                donation.status = .completed

            default:
                break
            }

            navigationController?.popViewController(animated: true)
        }
    }

    private extension DateFormatter {
        static let dmy: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            return df
        }()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
