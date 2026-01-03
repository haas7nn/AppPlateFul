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
    
    // MARK: - IBActions
    @IBAction func communityLeaderboardTapped(_ sender: UIButton) {
        print("📍 Community Leaderboard tapped")
        showComingSoon(feature: "Community Leaderboard")
    }
    
    @IBAction func favouriteNGOsTapped(_ sender: UIButton) {
        print("📍 Favourite NGOs tapped")
        
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrganizationDiscoveryVC")
        
        if let nav = navigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction func myDonationsTapped(_ sender: UIButton) {
        print("📍 My Donations tapped")
        showComingSoon(feature: "My Donations")
    }
    
    @IBAction func trackDeliveriesTapped(_ sender: UIButton) {
        print("📍 Track Deliveries tapped")
        openTrackingOrder()
    }
    
    @IBAction func donationUpdatesTapped(_ sender: UIButton) {
        print("📍 Donation Updates tapped")
        openDonationsList()
    }
    
    @IBAction func recurringDonationsTapped(_ sender: UIButton) {
        print("📍 Recurring Donations tapped")
        showComingSoon(feature: "Recurring Donations")
    }
    
    // MARK: - Navigation to DonationsList Storyboard
    private func openDonationsList() {
        let storyboard = UIStoryboard(name: "DonationsList", bundle: nil)
        
        guard let donationsListVC = storyboard.instantiateViewController(withIdentifier: "DonationsListViewController") as? DonationsListViewController else {
            print("❌ Error: Could not find DonationsListViewController in DonationsList.storyboard")
            print("💡 Make sure Storyboard ID is set to 'DonationsListViewController' in Identity Inspector")
            return
        }
        
        donationsListVC.modalPresentationStyle = .fullScreen
        present(donationsListVC, animated: true)
        
        print("✅ Opened DonationsListViewController from DonationsList.storyboard")
    }
    
    // MARK: - Navigation to TrackingOrder Storyboard
    private func openTrackingOrder() {
        let storyboard = UIStoryboard(name: "TrackingOrder", bundle: nil)
        
        guard let trackingOrderVC = storyboard.instantiateViewController(withIdentifier: "TrackingOrderViewController") as? TrackingOrderViewController else {
            print("❌ Error: Could not find TrackingOrderViewController in TrackingOrder.storyboard")
            print("💡 Make sure Storyboard ID is set to 'TrackingOrderViewController' in Identity Inspector")
            return
        }
        
        trackingOrderVC.modalPresentationStyle = .fullScreen
        present(trackingOrderVC, animated: true)
        
        print("✅ Opened TrackingOrderViewController from TrackingOrder.storyboard")
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
