//
//  UserTableViewCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 29/12/2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // Use optional (?) to prevent crashes if outlets aren't connected
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var starButton: UIButton?
    @IBOutlet weak var infoButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        avatarImageView?.layer.cornerRadius = 25
        avatarImageView?.clipsToBounds = true
    }
    
    func configure(name: String, status: String, isStarred: Bool = false) {
        nameLabel?.text = name
        statusLabel?.text = status
        
        // Status color
        switch status.lowercased() {
        case "active":
            statusLabel?.textColor = .systemGreen
        case "inactive":
            statusLabel?.textColor = .systemRed
        case "pending":
            statusLabel?.textColor = .systemOrange
        default:
            statusLabel?.textColor = .secondaryLabel
        }
        
        // Star button
        let starImage = isStarred ? "star.fill" : "star"
        starButton?.setImage(UIImage(systemName: starImage), for: .normal)
        starButton?.tintColor = isStarred ? .systemYellow : .systemGray
        
        // Default avatar
        avatarImageView?.image = UIImage(systemName: "person.circle.fill")
        avatarImageView?.tintColor = .systemGray2
    }
}
