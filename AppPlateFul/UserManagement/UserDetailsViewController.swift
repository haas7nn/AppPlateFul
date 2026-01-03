//
//  UserDetailsViewController.swift
//  AppPlateFul
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Details"
        setupUI()
        configureContent()
    }
    
    // MARK: - Setup
    private func setupUI() {
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true
    }
    
    private func configureContent() {
        guard let user = user else { return }
        
        nameLabel.text = user.displayName
        emailLabel.text = user.email ?? "-"
        phoneLabel.text = user.phone ?? "-"
        
        roleLabel.text = user.role.rawValue.uppercased()
        statusLabel.text = user.status ?? "-"
        joinDateLabel.text = user.joinDate ?? "-"
        
        let iconName = user.profileImageName ?? "person.circle.fill"
        avatarImageView.image = UIImage(systemName: iconName)
        avatarImageView.tintColor = .systemGray2
    }
}

