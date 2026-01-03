//
//  NGOReviewDetailViewController.swift
//  AppPlateFul
//

import UIKit
import FirebaseFirestore

class NGOReviewDetailViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var donationsValueLabel: UILabel!
    @IBOutlet weak var reliabilityValueLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    var ngo: NGOReviewItem?
    var onDecision: ((String) -> Void)?

    private let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NGO Detail"
        setupUI()
        fillData()
    }

    private func setupUI() {
        logoImageView.layer.cornerRadius = 35
        logoImageView.clipsToBounds = true
        approveButton.layer.cornerRadius = 10
        rejectButton.layer.cornerRadius = 10
    }

    private func fillData() {
        guard let ngo = ngo else { return }

        nameLabel.text = ngo.name
        statusLabel.text = ngo.status
        areaValueLabel.text = ngo.area
        hoursValueLabel.text = ngo.openingHours
        pickupTimeValueLabel.text = ngo.avgPickupTime
        donationsValueLabel.text = ngo.collectedDonations
        reliabilityValueLabel.text = ngo.pickupReliability
        reviewsValueLabel.text = ngo.communityReviews
        logoImageView.image = ngo.logoImage
    }

    @IBAction func approveButtonTapped(_ sender: UIButton) {
        handleDecision(approved: true)
    }

    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        handleDecision(approved: false)
    }

    private func handleDecision(approved: Bool) {
        guard let ngo = ngo else { return }

        let reviewRef = db.collection("ngo_reviews").document(ngo.id)

        if approved {
            let approvedRef = db.collection("ngo_reviews").document(ngo.id)
            let batch = db.batch()
            batch.setData(ngo.toFirestoreData(), forDocument: approvedRef)
            batch.deleteDocument(reviewRef)
            commit(batch, approved: true)
        } else {
            let rejectedRef = db.collection("ngo_rejected").document(ngo.id)
            let batch = db.batch()
            batch.setData(ngo.toFirestoreData(), forDocument: rejectedRef)
            batch.deleteDocument(reviewRef)
            commit(batch, approved: false)
        }
    }

    private func commit(_ batch: WriteBatch, approved: Bool) {
        batch.commit { [weak self] err in
            if let err = err {
                print("Firestore error:", err.localizedDescription)
                return
            }

            if let id = self?.ngo?.id {
                self?.onDecision?(id)
            }
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
