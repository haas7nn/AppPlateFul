//
//  DonorHomeViewController.swift
//  AppPlateFul
//

import UIKit

class DonorHomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var communityLeaderboardBtn: UIButton?
    @IBOutlet weak var favouriteNGOsBtn: UIButton?
    @IBOutlet weak var myDonationsBtn: UIButton?
    @IBOutlet weak var trackDeliveriesBtn: UIButton?
    @IBOutlet weak var donationUpdatesBtn: UIButton?
    @IBOutlet weak var recurringDonationsBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🚀 DonorHome viewDidLoad")
        setupUI()
        setupAdminButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup
    private func setupUI() {
        let buttons = [
            communityLeaderboardBtn,
            favouriteNGOsBtn,
            myDonationsBtn,
            trackDeliveriesBtn,
            donationUpdatesBtn,
            recurringDonationsBtn
        ]
        
        for button in buttons {
            button?.layer.cornerRadius = 28
            button?.clipsToBounds = true
        }
    }
    
    // MARK: - Admin Button Setup
    private func setupAdminButton() {
        let adminButton = UIButton(type: .system)
        adminButton.setTitle("🔐 Admin Dashboard", for: .normal)
        adminButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        adminButton.backgroundColor = UIColor.systemBlue
        adminButton.setTitleColor(.white, for: .normal)
        adminButton.layer.cornerRadius = 28
        adminButton.clipsToBounds = true
        adminButton.translatesAutoresizingMaskIntoConstraints = false
        
        adminButton.addTarget(self, action: #selector(adminDashboardTapped), for: .touchUpInside)
        
        view.addSubview(adminButton)
        
        // Position at top right corner
        NSLayoutConstraint.activate([
            adminButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adminButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120), // move DOWN
            adminButton.widthAnchor.constraint(equalToConstant: 180),
            adminButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Admin Dashboard Navigation
    @objc private func adminDashboardTapped() {
        print("📍 Admin Dashboard tapped")
        
        let storyboard = UIStoryboard(name: "AdminDashboard", bundle: nil)
        
        guard let adminVC = storyboard.instantiateViewController(withIdentifier: "AdminDashboardViewController") as? AdminDashboardViewController else {
            print("❌ Could not find AdminDashboardViewController")
            showAlert(title: "Error", message: "Admin Dashboard not found")
            return
        }
        
        // Present with navigation controller for back button
        let navController = UINavigationController(rootViewController: adminVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func communityLeaderboardTapped(_ sender: UIButton) {
        print("📍 Community Leaderboard tapped")
        showComingSoon(feature: "Community Leaderboard")
    }
    
    @IBAction func favouriteNGOsTapped(_ sender: UIButton) {
        print("📍 Favourite NGOs tapped")
        
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)
        
        // Debug: Check if storyboard loads
        print("📍 Storyboard loaded: \(storyboard)")
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "OrganizationDiscoveryVC") as? OrganizationDiscoveryViewController else {
            print("❌ Could not find OrganizationDiscoveryVC")
            return
        }
        
        print("📍 ViewController created: \(vc)")
        
        if let nav = navigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            print("⚠️ No navigation controller, presenting modally")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction func myDonationsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DonationSchedulingStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sche")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func trackDeliveriesTapped(_ sender: UIButton) {
        print("📍 Track Deliveries tapped")
        showComingSoon(feature: "Track Deliveries")
    }
    
    @IBAction func donationUpdatesTapped(_ sender: UIButton) {
        print("📍 Donation Updates tapped")
        showComingSoon(feature: "Donation Updates")
    }
    
    @IBAction func recurringDonationsTapped(_ sender: UIButton) {
        print("📍 Recurring Donations tapped")
        showComingSoon(feature: "Recurring Donations")
    }
    
    // MARK: - Helpers
    private func showComingSoon(feature: String) {
        let alert = UIAlertController(
            title: "Coming Soon",
            message: "\(feature) feature coming soon!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
