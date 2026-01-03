//
//  DonationActivityCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//

// DonationActivityCell.swift

import UIKit

protocol DonationActivityCellDelegate: AnyObject {
    func didTapReport(for donation: DonationActivityDonation)
}

class DonationActivityCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var logoContainer: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var ngoNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: DonationActivityCellDelegate?
    private var donation: DonationActivityDonation?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = DonationTheme.backgroundColor
        
        cardContainer.layer.cornerRadius = 22
        cardContainer.backgroundColor = DonationTheme.cardBackground
        
        logoContainer.layer.cornerRadius = 12
        logoContainer.backgroundColor = .white
        
        reportButton.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    func configure(with donation: DonationActivityDonation) {
        self.donation = donation
        
        logoImageView.image = donation.ngoLogo ?? UIImage(systemName: "building.2.fill")
        logoImageView.tintColor = DonationTheme.primaryBrown
        
        ngoNameLabel.text = donation.ngoName
        statusLabel.text = donation.status.rawValue
        statusLabel.textColor = donation.status.color
        timestampLabel.text = donation.formattedCreatedDate
        
        itemsLabel.text = "Items: \(donation.itemsDisplayText)"
        statusDetailLabel.text = "Status: \(donation.status.rawValue)"
        
        if let pickupDate = donation.formattedPickupDate {
            pickupDateLabel.text = "Pickup Date: \(pickupDate)"
            pickupDateLabel.isHidden = false
        } else {
            pickupDateLabel.isHidden = true
        }
        
        reportButton.alpha = donation.isReported ? 0.5 : 1.0
        reportButton.isEnabled = !donation.isReported
    }
    
    // MARK: - Actions
    @objc private func reportTapped() {
        guard let donation else { return }
        delegate?.didTapReport(for: donation)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        ngoNameLabel.text = nil
        statusLabel.text = nil
        timestampLabel.text = nil
        itemsLabel.text = nil
        statusDetailLabel.text = nil
        pickupDateLabel.text = nil
        pickupDateLabel.isHidden = false
    }
}
