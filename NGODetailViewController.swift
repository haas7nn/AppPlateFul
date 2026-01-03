//
//  NGODetailViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 25/12/2025.
//

import UIKit

class NGODetailViewController: UIViewController {
    
    // MARK: - Properties
    var ngo: PendingNGO?
    var onDecision: ((String) -> Void)?
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        iv.tintColor = .systemBlue
        iv.image = UIImage(systemName: "building.2.crop.circle.fill")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemOrange
        label.text = "Pending Verification"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let approveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✓ Approve NGO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rejectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✗ Reject NGO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithNGO()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "NGO Verification Detail"
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(ratingsLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(approveButton)
        contentView.addSubview(rejectButton)
        
        approveButton.addTarget(self, action: #selector(approveButtonTapped), for: .touchUpInside)
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Logo
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Name
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            
            // Status
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Ratings
            ratingsLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            ratingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Info Stack
            infoStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Approve Button
            approveButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 40),
            approveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            approveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            approveButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Reject Button
            rejectButton.topAnchor.constraint(equalTo: approveButton.bottomAnchor, constant: 15),
            rejectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rejectButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rejectButton.heightAnchor.constraint(equalToConstant: 50),
            rejectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func configureWithNGO() {
        guard let ngo = ngo else { return }
        
        nameLabel.text = ngo.name
        ratingsLabel.text = "\(ngo.ratingsCount) ratings"
        
        // Add info rows
        addInfoRow(icon: "📍", title: "NGO area", value: ngo.area)
        addInfoRow(icon: "🕐", title: "Opening hours", value: ngo.openingHours)
        addInfoRow(icon: "⏱️", title: "Average Pickup Time", value: ngo.avgPickupTime)
        addInfoRow(icon: "🎁", title: "Collected Donations", value: ngo.collectedDonations)
        addInfoRow(icon: "✅", title: "Pickup Reliability", value: ngo.pickupReliability)
        addInfoRow(icon: "⭐", title: "Community Reviews", value: ngo.communityReviews)
    }
    
    private func addInfoRow(icon: String, title: String, value: String) {
        let rowView = UIView()
        rowView.backgroundColor = .secondarySystemBackground
        rowView.layer.cornerRadius = 8
        rowView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "\(icon) \(title)"
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .preferredFont(forTextStyle: .body)
        valueLabel.textColor = .secondaryLabel
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rowView.addSubview(titleLabel)
        rowView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            rowView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: rowView.trailingAnchor, constant: -12),
            valueLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
        
        infoStackView.addArrangedSubview(rowView)
    }
    
    // MARK: - Actions
    @objc private func approveButtonTapped() {
        showConfirmation(title: "Approve NGO", message: "Are you sure you want to approve this NGO?", isApproval: true)
    }
    
    @objc private func rejectButtonTapped() {
        showConfirmation(title: "Reject NGO", message: "Are you sure you want to reject this NGO?", isApproval: false)
    }
    
    private func showConfirmation(title: String, message: String, isApproval: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: isApproval ? .default : .destructive) { [weak self] _ in
            self?.showSuccess(isApproval: isApproval)
        })
        
        present(alert, animated: true)
    }
    
    private func showSuccess(isApproval: Bool) {
        let title = isApproval ? "Approved!" : "Rejected!"
        let message = isApproval ? "NGO has been approved successfully." : "NGO has been rejected."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self, let ngo = self.ngo else { return }
            self.onDecision?(ngo.id)
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}
