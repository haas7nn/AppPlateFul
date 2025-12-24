import UIKit

class AdminDashboardViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var pendingNGOsButton: UIButton!


    
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Apply pill shape to all buttons
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        
        for button in buttons {
            button?.layer.cornerRadius = 28
            button?.clipsToBounds = true
        }
    }
    
    // MARK: - Button Actions
        @IBAction func pendingNGOsTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "PendingNGOs", bundle: nil)

            if let navController = storyboard.instantiateViewController(withIdentifier: "PendingNGOsNavController") as? UINavigationController {
                navController.modalPresentationStyle = .fullScreen
                present(navController, animated: true)
            }
        }
    
    @IBAction func donationActivityTapped(_ sender: UIButton) {
        print("Donation Activity tapped")
        // Navigate to Donation Activity screen
    }
    
    @IBAction func manageUsersTapped(_ sender: UIButton) {
        print("Manage Users tapped")
        // Navigate to Manage Users screen
    }
    
    @IBAction func manageNGOsTapped(_ sender: UIButton) {
        print("Manage NGOs tapped")
        // Navigate to Manage NGOs screen
    }
    
    @IBAction func reportsTapped(_ sender: UIButton) {
        print("Reports tapped")
        // Navigate to Reports screen
    }
}
