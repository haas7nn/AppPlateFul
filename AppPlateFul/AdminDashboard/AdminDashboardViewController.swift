//
// AdminDashboardViewController.swift
// AppPlateFul
//

import UIKit

class AdminDashboardViewController: UIViewController {
    
    // MARK: - IBOutlets (Made optional to prevent crash)
    @IBOutlet weak var btn1: UIButton?
    @IBOutlet weak var btn2: UIButton?
    @IBOutlet weak var btn3: UIButton?
    @IBOutlet weak var btn4: UIButton?
    @IBOutlet weak var btn5: UIButton?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🚀 AdminDashboard viewDidLoad")
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    private func setupUI() {
        print("🔧 Setting up UI")
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        for button in buttons {
            button?.layer.cornerRadius = 28
            button?.clipsToBounds = true
        }
        print("✅ UI setup complete")
    }
    
    // MARK: - IBActions
    
    @IBAction func pendingNGOsTapped(_ sender: UIButton) {
        print("📍 Pending NGOs tapped")
        openPendingNGOs()
    }
    
    @IBAction func donationActivityTapped(_ sender: UIButton) {
        print("1️⃣ Button tapped")
        
        let storyboard = UIStoryboard(name: "DonationActivity", bundle: nil)
        print("2️⃣ Storyboard loaded")
        
        guard let donationVC = storyboard.instantiateViewController(withIdentifier: "DonationActivityViewController") as? DonationActivityViewController else {
            print("❌ Failed to instantiate DonationActivityViewController")
            showComingSoon(feature: "Donation Activity")
            return
        }
        
        print("3️⃣ ViewController created")
        navigationController?.pushViewController(donationVC, animated: true)
        print("4️⃣ Pushed")
    }
    
    @IBAction func manageUsersTapped(_ sender: UIButton) {
        print("📍 Manage Users tapped")
        let storyboard = UIStoryboard(name: "UserManagement", bundle: nil)
        
        // ✅ Get the UserListViewController directly and PUSH it
        if let userListVC = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController {
            navigationController?.pushViewController(userListVC, animated: true)
        } else {
            print("❌ Could not find UserListViewController")
            showComingSoon(feature: "Manage Users")
        }
    }
    
    @IBAction func manageNGOsTapped(_ sender: UIButton) {
        print("📍 Manage NGOs tapped")
        showComingSoon(feature: "Manage NGOs")
    }
    
    @IBAction func reportsTapped(_ sender: UIButton) {
        print("📍 Reports tapped")
        let storyboard = UIStoryboard(name: "Reports", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportsAnalyticsViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Navigation
    
    private func openPendingNGOs() {
        let storyboard = UIStoryboard(name: "NGOReview", bundle: nil)
        
        // ✅ Try to push instead of present if possible
        if let pendingVC = storyboard.instantiateViewController(withIdentifier: "PendingNGOsViewController") as? UIViewController {
            navigationController?.pushViewController(pendingVC, animated: true)
        } else if let navController = storyboard.instantiateViewController(withIdentifier: "NGOReviewNavController") as? UINavigationController {
            // Fallback to modal if needed
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        } else {
            showComingSoon(feature: "NGO Review")
        }
    }
    
    // MARK: - Helper
    
    private func showComingSoon(feature: String) {
        let alert = UIAlertController(
            title: "Coming Soon",
            message: "\(feature) feature coming soon!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
