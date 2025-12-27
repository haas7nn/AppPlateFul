//
//  NGOTableViewCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 25/12/2025.
//

import Foundation
import UIKit

class NGOTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.layer.cornerRadius = 25
        logoImageView.clipsToBounds = true
        
        // Set default placeholder image
        logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
    }
    
    func configure(with ngo: PendingNGO) {
        nameLabel.text = ngo.name
        statusLabel.text = ngo.status
        
        if let image = UIImage(named: ngo.logoName) {
            logoImageView.image = image
        } else {
            logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        }
    }
}
