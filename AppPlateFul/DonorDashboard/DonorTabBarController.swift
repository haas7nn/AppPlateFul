//
//  DonorTabBarController.swift
//  AppPlateFul
//

import UIKit

class DonorTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    // Donate tab is at index 2 (Home=0, Find NGOs=1, Donate=2, History=3, Profile=4)
    private let donateTabIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🚀 DonorTabBar viewDidLoad")
        setupTabBar()
        self.delegate = self
    }
    
    private func setupTabBar() {
        let greenColor = UIColor(red: 0.725, green: 0.796, blue: 0.631, alpha: 1)
        let creamColor = UIColor(red: 0.969, green: 0.957, blue: 0.933, alpha: 1)
        
        tabBar.tintColor = greenColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = creamColor
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = creamColor
            appearance.stackedLayoutAppearance.selected.iconColor = greenColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: greenColor]
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let viewControllers = tabBarController.viewControllers,
              let index = viewControllers.firstIndex(of: viewController) else {
            return true
        }
        
        // Check if Donate tab is being tapped
        if index == donateTabIndex {
            print("📍 Donate tab tapped - opening AddDonations storyboard")
            openAddDonationScreen()
            return false  // Prevent default tab selection
        }
        
        return true  // Allow other tabs to work normally
    }
    
    // MARK: - Navigation to AddDonation (from separate storyboard)
    private func openAddDonationScreen() {
        // Load from your separate AddDonations.storyboard
        let storyboard = UIStoryboard(name: "AddDonations", bundle: nil)
        
        guard let addDonationVC = storyboard.instantiateViewController(withIdentifier: "AddDonationViewController") as? AddDonationViewController else {
            print("❌ Error: Could not find AddDonationViewController in AddDonations.storyboard")
            print("💡 Make sure Storyboard ID is set to 'AddDonationViewController' in Identity Inspector")
            return
        }
        
        // Wrap in navigation controller for proper navigation to receipt screen
        let navController = UINavigationController(rootViewController: addDonationVC)
        navController.modalPresentationStyle = .fullScreen
        
        // Present the AddDonation screen
        present(navController, animated: true)
        
        print("✅ Opened AddDonationViewController from AddDonations.storyboard")
    }
}
