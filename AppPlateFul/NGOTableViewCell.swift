//
//  NGOTableViewCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

class NGOTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        statusLabel.text = nil
        logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
    }
    
    // MARK: - Setup
    private func setupUI() {
        logoImageView.layer.cornerRadius = 25
        logoImageView.clipsToBounds = true
        logoImageView.tintColor = .systemBlue
        
        detailLabel.textColor = .systemBlue
    }
    
    // MARK: - Configure
    func configure(with ngo: NGO) {
        nameLabel.text = ngo.name
        statusLabel.text = ngo.status.rawValue
        statusLabel.textColor = ngo.status.color
        
        if let logo = ngo.logoImage {
            logoImageView.image = logo
        } else {
            logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        }
    }
}
