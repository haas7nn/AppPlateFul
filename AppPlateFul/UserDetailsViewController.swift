//
//  UserDetailsViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    // Quick Action Buttons
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    // User Information
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var verificationLabel: UILabel!
    
    // Activity Summary
    @IBOutlet weak var donorTypeLabel: UILabel!
    @IBOutlet weak var donationsMadeLabel: UILabel!
    @IBOutlet weak var mealsProvidedLabel: UILabel!
    @IBOutlet weak var notificationsLabel: UILabel!
    
    // Contact Information
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithUser()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Details"
        
        profileAvatar.layer.cornerRadius = 50
        profileAvatar.clipsToBounds = true
        profileAvatar.tintColor = .systemGray2
        
        setupQuickActionButton(callButton)
        setupQuickActionButton(emailButton)
        setupQuickActionButton(locationButton)
    }
    
    private func setupQuickActionButton(_ button: UIButton) {
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
    }
    
    private func configureWithUser() {
        guard let user = user else {
            loadDefaultData()
            return
        }
        
        // Profile
        profileName.text = user.name
        if let avatar = user.avatarImage {
            profileAvatar.image = avatar
        } else {
            profileAvatar.image = UIImage(systemName: "person.circle.fill")
        }
        
        // User Information
        statusLabel.text = user.status
        statusLabel.textColor = user.status.lowercased() == "active" ? .systemGreen : .systemGray
        roleLabel.text = user.role
        verificationLabel.text = user.isVerified ? "Verified User" : "Not Verified"
        verificationLabel.textColor = user.isVerified ? .systemBlue : .systemGray
        
        // Activity Summary
        donorTypeLabel.text = user.donorType
        donationsMadeLabel.text = "\(user.donationsMade)"
        mealsProvidedLabel.text = "\(user.mealsProvided)"
        notificationsLabel.text = user.notificationsEnabled ? "Enabled" : "Disabled"
        notificationsLabel.textColor = user.notificationsEnabled ? .systemGreen : .systemGray
        
        // Contact Information
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        addressLabel.text = user.address
    }
    
    private func loadDefaultData() {
        profileName.text = "Abdulwahid"
        profileAvatar.image = UIImage(systemName: "person.circle.fill")
        
        statusLabel.text = "Active"
        statusLabel.textColor = .systemGreen
        roleLabel.text = "Donor"
        verificationLabel.text = "Verified User"
        verificationLabel.textColor = .systemBlue
        
        donorTypeLabel.text = "Individual"
        donationsMadeLabel.text = "18"
        mealsProvidedLabel.text = "92"
        notificationsLabel.text = "Enabled"
        notificationsLabel.textColor = .systemGreen
        
        phoneLabel.text = "+973 37282388"
        emailLabel.text = "abdulwahid@gmail.com"
        addressLabel.text = "Manama, Bahrain"
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Edit User", message: "Edit functionality will be implemented here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        guard let phone = phoneLabel.text,
              let url = URL(string: "tel://\(phone.replacingOccurrences(of: " ", with: ""))") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Cannot make phone call on this device.")
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard let email = emailLabel.text,
              let url = URL(string: "mailto:\(email)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Cannot send email on this device.")
        }
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        guard let address = addressLabel.text,
              let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "maps://?q=\(encodedAddress)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Cannot open maps on this device.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
