//
//  AdminDashboardViewController.swift
//  AppPlateFul
//
//  202301686 - Hasan
//

import UIKit

// Admin dashboard screen for system administrators
class AdminDashboardViewController: UIViewController {
    
    // MARK: - IBOutlets
    // Main dashboard action buttons
    @IBOutlet weak var btn1: UIButton?
    @IBOutlet weak var btn2: UIButton?
    @IBOutlet weak var btn3: UIButton?
    @IBOutlet weak var btn4: UIButton?
    @IBOutlet weak var btn5: UIButton?
    
    // MARK: - Lifecycle
    // Called when the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Hides navigation bar when dashboard appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Restores navigation bar when leaving dashboard
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    // Applies consistent UI styling to dashboard buttons
    private func setupUI() {
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        for button in buttons {
            button?.layer.cornerRadius = 28
            button?.clipsToBounds = true
        }
    }
    
    // MARK: - IBActions
    // Opens the pending NGO review screen
    @IBAction func pendingNGOsTapped(_ sender: UIButton) {
        openPendingNGOs()
    }
    
    // Navigates to donation activity screen
    @IBAction func donationActivityTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DonationActivity", bundle: nil)
        
        guard let donationVC = storyboard.instantiateViewController(
            withIdentifier: "DonationActivityViewController"
        ) as? DonationActivityViewController else {
            showComingSoon(feature: "Donation Activity")
            return
        }
        
        navigationController?.pushViewController(donationVC, animated: true)
    }
    
    // Navigates to user management screen
    @IBAction func manageUsersTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "UserManagement", bundle: nil)
        
        if let userListVC = storyboard.instantiateViewController(
            withIdentifier: "UserListViewController"
        ) as? UserListViewController {
            navigationController?.pushViewController(userListVC, animated: true)
        } else {
            showComingSoon(feature: "Manage Users")
        }
    }
    
    // Placeholder for NGO management feature
    @IBAction func manageNGOsTapped(_ sender: UIButton) {
        showComingSoon(feature: "Manage NGOs")
    }
    
    // Opens reports and analytics screen
    @IBAction func reportsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Reports", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "ReportsAnalyticsViewController"
        )
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Navigation
    // Navigates to NGO review list screen
    private func openPendingNGOs() {
        let storyboard = UIStoryboard(name: "NGOReview", bundle: nil)
        
        guard let listVC = storyboard.instantiateViewController(
            withIdentifier: "NGOReviewListViewController"
        ) as? NGOReviewListViewController else {
            showComingSoon(feature: "NGO Review")
            return
        }
        
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    // MARK: - Helper
    // Displays a temporary alert for unavailable features
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
