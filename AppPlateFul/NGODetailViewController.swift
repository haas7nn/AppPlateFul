//
//  NGODetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 21/12/2025.
//

import UIKit

class NGODetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ngoLogoImageView: UIImageView!
    @IBOutlet weak var ngoNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var donationsValueLabel: UILabel!
    @IBOutlet weak var reliabilityValueLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    // MARK: - Properties
    var ngo: NGO?
    var ngoIndex: Int = 0
    weak var delegate: NGODetailDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithNGO()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "NGO Verification Detail"
        
        ngoLogoImageView.layer.cornerRadius = 40
        ngoLogoImageView.clipsToBounds = true
        
        approveButton.layer.cornerRadius = 25
        rejectButton.layer.cornerRadius = 25
    }
    
    private func configureWithNGO() {
        guard let ngo = ngo else {
            loadDefaultData()
            return
        }
        
        // Header
        ngoNameLabel.text = ngo.name
        statusLabel.text = ngo.status.rawValue
        statusLabel.textColor = ngo.status.color
        ratingsLabel.text = "\(ngo.ratingsCount) ratings"
        
        if let logo = ngo.logoImage {
            ngoLogoImageView.image = logo
        } else {
            ngoLogoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        }
        
        // Information
        areaValueLabel.text = ngo.area
        hoursValueLabel.text = ngo.openingHours
        pickupTimeValueLabel.text = ngo.averagePickupTime
        donationsValueLabel.text = ngo.collectedDonations
        reliabilityValueLabel.text = ngo.pickupReliability
        reviewsValueLabel.text = ngo.communityReviews
    }
    
    private func loadDefaultData() {
        ngoNameLabel.text = "Islamic Hands"
        statusLabel.text = "Pending Verification"
        statusLabel.textColor = .systemOrange
        ratingsLabel.text = "122 ratings"
        ngoLogoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        
        areaValueLabel.text = "Sitra, Bahrain"
        hoursValueLabel.text = "9:00AM - 9:00PM"
        pickupTimeValueLabel.text = "22 minutes"
        donationsValueLabel.text = "16 this month"
        reliabilityValueLabel.text = "100% on-time"
        reviewsValueLabel.text = "N/A"
    }
    
    // MARK: - Actions
    @IBAction func approveButtonTapped(_ sender: UIButton) {
        showApprovalPopup()
    }
    
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        showRejectionPopup()
    }
    
    // MARK: - Popups
    private func showApprovalPopup() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Create custom view for popup
        let customView = createPopupView(
            icon: "checkmark.circle.fill",
            iconColor: .systemGreen,
            message: "NGO approved successfully."
        )
        
        alert.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Add height constraint to alert
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 180)
        alert.view.addConstraint(height)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.delegate?.didApproveNGO(at: self.ngoIndex)
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showRejectionPopup() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Create custom view for popup
        let customView = createPopupView(
            icon: "xmark.circle.fill",
            iconColor: .systemRed,
            message: "NGO rejected."
        )
        
        alert.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Add height constraint to alert
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 180)
        alert.view.addConstraint(height)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.delegate?.didRejectNGO(at: self.ngoIndex)
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func createPopupView(icon: String, iconColor: UIColor, message: String) -> UIView {
        let containerView = UIView()
        
        // Icon
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = iconColor
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
        
        // Message Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        messageLabel.textColor = .label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        return containerView
    }
}
