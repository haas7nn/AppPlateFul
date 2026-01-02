//
//  DonationDetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//


import UIKit

class DonationDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailLogoImageView: UIImageView!
    @IBOutlet weak var detailNgoNameLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var itemsStackView: UIStackView!
    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var changeStatusButton: UIButton!
    
    // MARK: - Properties
    var donation: Donation!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureContent()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = DonationTheme.backgroundColor
        title = "Donation Details"
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleStatusUpdate),
            name: .donationStatusUpdated, object: nil
        )
    }
    
    // MARK: - Configuration
    private func configureContent() {
        guard let donation = donation else { return }
        
        detailLogoImageView.image = donation.ngoLogo ?? UIImage(systemName: "building.2.fill")
        detailLogoImageView.tintColor = DonationTheme.primaryBrown
        
        detailNgoNameLabel.text = donation.ngoName
        detailDateLabel.text = donation.formattedCreatedDate
        
        addressLabel.text = donation.address.formattedAddress
        phoneLabel.text = "📞 \(donation.address.mobileNumber)"
        
        // Clear existing items
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add items
        for item in donation.items {
            let itemLabel = UILabel()
            itemLabel.font = UIFont.systemFont(ofSize: 13)
            itemLabel.textColor = DonationTheme.textSecondary
            itemLabel.text = "• \(item.name) (x\(item.quantity))"
            itemsStackView.addArrangedSubview(itemLabel)
        }
        
        updateStatusDisplay()
    }
    
    private func updateStatusDisplay() {
        currentStatusLabel.text = donation.status.rawValue
        currentStatusLabel.textColor = donation.status.color
    }
    
    // MARK: - Actions
    @IBAction func changeStatusTapped(_ sender: Any) {
        let changeStatusVC = ChangeStatusViewController(currentStatus: donation.status)
        changeStatusVC.delegate = self
        changeStatusVC.modalPresentationStyle = .overCurrentContext
        changeStatusVC.modalTransitionStyle = .crossDissolve
        present(changeStatusVC, animated: true)
    }
    
    @objc private func handleStatusUpdate(_ notification: Notification) {
        if let updatedDonation = notification.object as? Donation,
           updatedDonation.id == donation.id {
            self.donation = updatedDonation
            updateStatusDisplay()
        }
    }
}

// MARK: - ChangeStatusDelegate
extension DonationDetailViewController: ChangeStatusDelegate {
    func didChangeStatus(to newStatus: DonationStatus) {
        DonationDataProvider.shared.updateDonationStatus(donationId: donation.id, newStatus: newStatus)
        
        let successPopup = StatusUpdatedPopup(
            icon: UIImage(systemName: "checkmark.circle.fill"),
            message: "Status Updated",
            iconColor: DonationTheme.statusCompleted
        )
        successPopup.modalPresentationStyle = .overCurrentContext
        successPopup.modalTransitionStyle = .crossDissolve
        present(successPopup, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                successPopup.dismiss(animated: true)
            }
        }
    }
}
