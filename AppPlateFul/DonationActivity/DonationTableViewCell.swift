//
//  DonationTableViewCell.swift
//  AppPlateFul
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets (made optional with ?)
    @IBOutlet weak var logoImageView: UIImageView?
    @IBOutlet weak var ngoNameLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        logoImageView?.layer.cornerRadius = 10
        logoImageView?.clipsToBounds = true
    }
    
    // MARK: - Configuration
    func configure(with donation: Donation) {
        logoImageView?.image = donation.ngoLogo ?? UIImage(systemName: "building.2.fill")
        logoImageView?.tintColor = DonationTheme.primaryBrown
        
        ngoNameLabel?.text = donation.ngoName
        statusLabel?.text = donation.status.rawValue
        statusLabel?.textColor = donation.status.color
        dateLabel?.text = donation.formattedCreatedDate
        
        // Debug: Check if outlets are connected
        print("🔍 logoImageView: \(logoImageView != nil ? "✅" : "❌")")
        print("🔍 ngoNameLabel: \(ngoNameLabel != nil ? "✅" : "❌")")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView?.image = nil
        ngoNameLabel?.text = nil
        statusLabel?.text = nil
        dateLabel?.text = nil
    }
}
