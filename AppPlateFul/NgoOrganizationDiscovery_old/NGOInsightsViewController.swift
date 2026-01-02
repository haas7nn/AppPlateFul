//
//  NGOInsightsViewController.swift
//  AppPlateFul
//
//  Created by Hassan on 28/12/2025.
//

import UIKit

class NGOInsightsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var verifiedBadgeView: UIView!
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var donationsValueLabel: UILabel!
    @IBOutlet weak var reliabilityValueLabel: UILabel!
    @IBOutlet weak var communityReviewValueLabel: UILabel!
    @IBOutlet weak var leaveReviewButton: UIButton!
    
    // MARK: - Data (passed from previous screen)
    var ngoName: String = ""
    var ngoImageName: String = ""
    var ngoRating: Double = 0.0
    var ngoReviews: Int = 0
    var isVerified: Bool = false
    var ngoAddress: String = ""
    
    // Insights specific data
    var openingHours: String = "8:00AM – 9:00PM"
    var averagePickupTime: String = "40 mins"
    var collectedDonations: String = "99 this month"
    var pickupReliability: String = "96% on-time"
    var communityReview: String = "Safe food handling and fast delivery"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feedback & Rating"
        configureNavigationBar()
        configureUI()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.969, green: 0.957, blue: 0.949, alpha: 1.0)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1.0),
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func configureUI() {
        // Logo Image
        if let image = UIImage(named: ngoImageName) {
            logoImageView?.image = image
        } else {
            logoImageView?.image = UIImage(systemName: "building.2.fill")
            logoImageView?.tintColor = .gray
            logoImageView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }
        
        // Organization Name
        orgNameLabel?.text = ngoName.isEmpty ? "Handful Love" : ngoName
        
        // Subtitle
        subtitleLabel?.text = "Food Collection Partner"
        
        // Ratings Count
        ratingsCountLabel?.text = "\(ngoReviews) ratings"
        
        // Verified Badge
        verifiedBadgeView?.isHidden = !isVerified
        
        // Information Row Values
        areaValueLabel?.text = extractArea(from: ngoAddress)
        hoursValueLabel?.text = openingHours
        pickupTimeValueLabel?.text = averagePickupTime
        donationsValueLabel?.text = collectedDonations
        reliabilityValueLabel?.text = pickupReliability
        communityReviewValueLabel?.text = communityReview
    }
    
    private func extractArea(from address: String) -> String {
        // Extract the city/area from the address
        if address.isEmpty {
            return "Hamad Town"
        }
        let components = address.components(separatedBy: ",")
        return components.first?.trimmingCharacters(in: .whitespaces) ?? "Hamad Town"
    }
    
    // MARK: - Actions
    @IBAction func leaveReviewTapped(_ sender: UIButton) {
        // Present the Add Review dialog
        let addReviewVC = AddReviewViewController()
        addReviewVC.ngoName = ngoName
        addReviewVC.delegate = self
        addReviewVC.modalPresentationStyle = .overFullScreen
        addReviewVC.modalTransitionStyle = .crossDissolve
        present(addReviewVC, animated: true)
    }
}

// MARK: - AddReviewDelegate
extension NGOInsightsViewController: AddReviewDelegate {
    func didAddReview(name: String, rating: Int, comment: String) {
        // Save the review
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        let key = "reviews_\(ngoName)"
        var reviews = UserDefaults.standard.array(forKey: key) as? [[String: Any]] ?? []
        
        let newReview: [String: Any] = [
            "name": name,
            "rating": rating,
            "comment": comment,
            "date": dateString
        ]
        reviews.insert(newReview, at: 0)
        UserDefaults.standard.set(reviews, forKey: key)
        
        // Show success message
        let alert = UIAlertController(
            title: "Thank You! 🎉",
            message: "Your review has been submitted successfully.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
