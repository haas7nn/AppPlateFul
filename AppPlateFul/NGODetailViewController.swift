//
//  NGODetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//

import UIKit

class NGODetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var donationsValueLabel: UILabel!
    @IBOutlet weak var reliabilityValueLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    // MARK: - Properties
    var ngo: PendingNGO?
    var onDecision: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithNGO()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "NGO Verification Detail"
        
        logoImageView.layer.cornerRadius = 40
        logoImageView.clipsToBounds = true
        logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        logoImageView.tintColor = .systemBlue
        
        approveButton.layer.cornerRadius = 25
        rejectButton.layer.cornerRadius = 25
    }
    
    private func configureWithNGO() {
        guard let ngo = ngo else { return }
        
        nameLabel.text = ngo.name
        statusLabel.text = ngo.status
        ratingsLabel.text = "\(ngo.ratingsCount) ratings"
        areaValueLabel.text = ngo.area
        hoursValueLabel.text = ngo.openingHours
        pickupTimeValueLabel.text = ngo.avgPickupTime
        donationsValueLabel.text = ngo.collectedDonations
        reliabilityValueLabel.text = ngo.pickupReliability
        reviewsValueLabel.text = ngo.communityReviews
    }
    
    // MARK: - Actions
    @IBAction func approveButtonTapped(_ sender: UIButton) {
        showConfirmation(title: "Approve NGO", message: "Are you sure?", isApproval: true)
    }
    
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        showConfirmation(title: "Reject NGO", message: "Are you sure?", isApproval: false)
    }
    
    private func showConfirmation(title: String, message: String, isApproval: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: isApproval ? .default : .destructive) { [weak self] _ in
            self?.showSuccess(isApproval: isApproval)
        })
        present(alert, animated: true)
    }
    
    private func showSuccess(isApproval: Bool) {
        let title = isApproval ? "Approved!" : "Rejected!"
        let message = isApproval ? "NGO has been approved." : "NGO has been rejected."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self, let ngo = self.ngo else { return }
            self.onDecision?(ngo.id)
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
