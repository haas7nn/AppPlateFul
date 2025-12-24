//
//  UserTableViewCell.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

protocol UserCellDelegate: AnyObject {
    func didTapInfoButton(at indexPath: IndexPath)
    func didTapStarButton(at indexPath: IndexPath)
}

class UserTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        statusLabel.text = nil
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
    }
    
    // MARK: - Setup
    private func setupUI() {
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        avatarImageView.tintColor = .systemGray2
        
        starButton.tintColor = .systemYellow
        infoButton.tintColor = .systemBlue
    }
    
    // MARK: - Configure
    func configure(with user: User) {
        nameLabel.text = user.name
        statusLabel.text = user.status
        
        // Set status color
        if user.status.lowercased() == "active" {
            statusLabel.textColor = .systemGreen
        } else {
            statusLabel.textColor = .systemGray
        }
        
        // Set star icon
        let starImage = user.isFavorite ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: starImage), for: .normal)
        starButton.tintColor = user.isFavorite ? .systemYellow : .systemGray3
        
        // Set avatar
        if let avatarImage = user.avatarImage {
            avatarImageView.image = avatarImage
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle.fill")
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
