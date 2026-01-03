//
//  UserTableViewCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: UserCellDelegate?
    var indexPath: IndexPath?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        profileImageView?.layer.cornerRadius = 25
        profileImageView?.clipsToBounds = true
        profileImageView?.image = UIImage(systemName: "person.circle.fill")
        profileImageView?.tintColor = .systemBlue
        
        statusLabel?.layer.cornerRadius = 8
        statusLabel?.clipsToBounds = true
    }
    
    // MARK: - Configure
    func configure(with user: User) {
        nameLabel?.text = user.name
        roleLabel?.text = user.role
        statusLabel?.text = user.status
        
        // Status color
        if user.status == "Active" {
            statusLabel?.textColor = .systemGreen
        } else {
            statusLabel?.textColor = .systemRed
        }
        
        // Star button
        let starImage = user.isFavorite ? "star.fill" : "star"
        starButton?.setImage(UIImage(systemName: starImage), for: .normal)
        starButton?.tintColor = user.isFavorite ? .systemYellow : .systemGray
        
        // Profile image
        if let image = UIImage(named: user.profileImageName) {
            profileImageView?.image = image
        } else {
            profileImageView?.image = UIImage(systemName: "person.circle.fill")
        }
    }
    
    // MARK: - Actions
    @IBAction func starButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        delegate?.didTapStarButton(at: indexPath)
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        guard let indexPath = indexPath else { return }
        delegate?.didTapInfoButton(at: indexPath)
    }
}
