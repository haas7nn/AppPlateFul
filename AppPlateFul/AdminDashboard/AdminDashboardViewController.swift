import UIKit

class AdminDashboardViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        for button in buttons {
            button?.layer.cornerRadius = 28
            button?.clipsToBounds = true
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func pendingNGOsTapped(_ sender: UIButton) {
        openPendingNGOs()
    }
    
    @IBAction func donationActivityTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DonationActivity", bundle: nil)
        if let donationVC = storyboard.instantiateViewController(withIdentifier: "DonationActivityViewController") as? DonationActivityViewController {
            navigationController?.pushViewController(donationVC, animated: true)
        }
    }
    
    @IBAction func manageUsersTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "UserManagement", bundle: nil)
        
        // Use the storyboard identifier directly
        if let navController = storyboard.instantiateViewController(withIdentifier: "UserManagementNavController") as? UINavigationController {
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        } else {
            print("❌ Could not find UserManagementNavController")
            showComingSoon(feature: "Manage Users")
        }
    
    }
    
    @IBAction func manageNGOsTapped(_ sender: UIButton) {
        showComingSoon(feature: "Manage NGOs")
    }
    
    @IBAction func reportsTapped(_ sender: UIButton) {
        showComingSoon(feature: "Reports")
    }
    
    // MARK: - Navigation
    
    private func openPendingNGOs() {
        let storyboard = UIStoryboard(name: "NGOReview", bundle: nil)
        if let navController = storyboard.instantiateViewController(withIdentifier: "NGOReviewNavController") as? UINavigationController {
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
