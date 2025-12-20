//
//  NGODetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 21/12/2025.
//

import UIKit

class NGODetailViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var ngoNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var openingHoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var collectedDonationsValueLabel: UILabel!
    @IBOutlet weak var pickupReliabilityValueLabel: UILabel!
    @IBOutlet weak var communityReviewsValueLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    var ngo: PendingNGO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithNGO()
    }
    
    private func configureWithNGO() {
        guard let ngo = ngo else { return }
        
        logoImageView.image = ngo.logoImage
        logoImageView.tintColor = .systemGray
        ngoNameLabel.text = ngo.name
        ratingsLabel.text = "\(ngo.ratingsCount) ratings"
        areaValueLabel.text = ngo.area
        openingHoursValueLabel.text = ngo.openingHours
        pickupTimeValueLabel.text = ngo.avgPickupTime
        collectedDonationsValueLabel.text = ngo.collectedDonations
        pickupReliabilityValueLabel.text = ngo.pickupReliability
        communityReviewsValueLabel.text = ngo.communityReviews
    }
    
    @IBAction func approveButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Approve NGO", message: "Are you sure you want to approve \(ngo?.name ?? "this NGO")?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Approve", style: .default) { [weak self] _ in
            self?.showSuccessAndPop(message: "NGO approved successfully!")
        })
        present(alert, animated: true)
    }
    
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reject NGO", message: "Are you sure you want to reject \(ngo?.name ?? "this NGO")?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reject", style: .destructive) { [weak self] _ in
            self?.showSuccessAndPop(message: "NGO rejected.")
        })
        present(alert, animated: true)
    }
    
    private func showSuccessAndPop(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
