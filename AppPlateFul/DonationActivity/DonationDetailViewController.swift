//
//  DonationDetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//


import UIKit

class DonationDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailLogoImageView: UIImageView!
    @IBOutlet weak var detailNgoNameLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var itemsStackView: UIStackView!
    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var changeStatusButton: UIButton!
    
    var donation: DonationActivityDonation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureContent()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        view.backgroundColor = DonationTheme.backgroundColor
        title = "Donation Details"
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleStatusUpdate),
            name: .donationStatusUpdated,
            object: nil
        )
    }
    
    private func configureContent() {
        guard let donation else { return }
        
        detailLogoImageView.image = donation.ngoLogo ?? UIImage(systemName: "building.2.fill")
        detailLogoImageView.tintColor = DonationTheme.primaryBrown
        
        detailNgoNameLabel.text = donation.ngoName
        detailDateLabel.text = donation.formattedCreatedDate
        
        addressLabel.text = donation.address.formattedAddress
        phoneLabel.text = "📞 \(donation.address.mobileNumber)"
        
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
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
        guard let donation else { return }
        currentStatusLabel.text = donation.status.rawValue
        currentStatusLabel.textColor = donation.status.color
    }
    
    @IBAction func changeStatusTapped(_ sender: Any) {
        guard let donation else { return }
        let changeStatusVC = ChangeStatusViewController(currentStatus: donation.status)
        changeStatusVC.delegate = self
        changeStatusVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        changeStatusVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(changeStatusVC, animated: true)
    }
    
    @objc private func handleStatusUpdate(_ notification: Notification) {
        guard let updatedDonation = notification.object as? DonationActivityDonation,
              let donation,
              updatedDonation.id == donation.id else {
            return
        }
        
        self.donation = updatedDonation
        updateStatusDisplay()
    }
}

extension DonationDetailViewController: ChangeStatusDelegate {
    func didChangeStatus(to newStatus: DonationActivityStatus) {
        guard let donation else { return }
        
        DonationDataProvider.shared.updateDonationStatus(
            donationId: donation.id,
            newStatus: newStatus
        )
        
        let successPopup = StatusUpdatedPopup(
            icon: UIImage(systemName: "checkmark.circle.fill"),
            message: "Status Updated",
            iconColor: DonationTheme.statusCompleted
        )
        
        successPopup.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        successPopup.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(successPopup, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                successPopup.dismiss(animated: true)
            }
        }
    }
}
