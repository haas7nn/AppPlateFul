//
//  NGOCardCell.swift
//  AppPlateFul
//
//  202301625 - Samana
//

import UIKit

// Delegate protocol for handling "Learn More" action on NGO card
protocol NGOCardCellDelegate: AnyObject {
    func didTapLearnMore(at cell: NGOCardCell)
}

// Collection view cell representing an NGO card in the discovery screen
class NGOCardCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var verifiedBadgeView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var learnMoreButton: UIButton!
    
    // MARK: - Delegate
    weak var delegate: NGOCardCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Attach action to Learn More button
        learnMoreButton.addTarget(
            self,
            action: #selector(learnMoreTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    // Notifies delegate when Learn More button is tapped
    @objc private func learnMoreTapped() {
        delegate?.didTapLearnMore(at: self)
    }
}
