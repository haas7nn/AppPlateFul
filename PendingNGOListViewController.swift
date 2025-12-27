//
//  PendingNGOListViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 25/12/2025.
//

import UIKit

class PendingNGOListViewController: UIViewController {
    
    // MARK: - UI Elements (Programmatic)
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter ▼", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 80
        table.register(UITableViewCell.self, forCellReuseIdentifier: "NGOCell")
        return table
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No enough data yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    // MARK: - Properties
    var pendingNGOs: [PendingNGO] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadSampleData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Pending NGO Verifications"
        view.backgroundColor = .systemBackground
        
        // Add close button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(closeTapped)
        )
        
        // Add subviews
        view.addSubview(filterButton)
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup filter button
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Filter Button
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterButton.widthAnchor.constraint(equalToConstant: 80),
            filterButton.heightAnchor.constraint(equalToConstant: 34),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Empty State Label
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadSampleData() {
        pendingNGOs = [
            PendingNGO(
                id: "1",
                name: "Islamic Hands",
                logoName: "IslamicHands",
                ratingsCount: 122,
                area: "Sadad, Bahrain",
                openingHours: "9:00AM - 9:00PM",
                avgPickupTime: "22 minutes",
                collectedDonations: "16 this month",
                pickupReliability: "100% on-time",
                communityReviews: "N/A"
            ),
            PendingNGO(
                id: "2",
                name: "Salmonda Helps",
                logoName: "SalmondaHelps",
                ratingsCount: 85,
                area: "Sitra, Bahrain",
                openingHours: "8:00AM - 6:00PM",
                avgPickupTime: "15 minutes",
                collectedDonations: "24 this month",
                pickupReliability: "95% on-time",
                communityReviews: "4.5 stars"
            )
        ]
        updateEmptyState()
        tableView.reloadData()
    }
    
    private func updateEmptyState() {
        emptyStateLabel.isHidden = !pendingNGOs.isEmpty
        tableView.isHidden = pendingNGOs.isEmpty
    }
    
    // MARK: - Actions
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func filterButtonTapped() {
        let alert = UIAlertController(title: "Filter", message: "Select filter option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All", style: .default) { _ in
            self.loadSampleData()
        })
        
        alert.addAction(UIAlertAction(title: "Highest Ratings", style: .default) { _ in
            self.pendingNGOs.sort { $0.ratingsCount > $1.ratingsCount }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Lowest Ratings", style: .default) { _ in
            self.pendingNGOs.sort { $0.ratingsCount < $1.ratingsCount }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = filterButton
            popover.sourceRect = filterButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    func removeNGO(withId id: String) {
        pendingNGOs.removeAll { $0.id == id }
        tableView.reloadData()
        updateEmptyState()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension PendingNGOListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingNGOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell", for: indexPath)
        let ngo = pendingNGOs[indexPath.row]
        
        // Configure cell
        var content = cell.defaultContentConfiguration()
        content.text = ngo.name
        content.secondaryText = "Pending Verification"
        content.secondaryTextProperties.color = .systemOrange
        content.image = UIImage(systemName: "building.2.crop.circle.fill")
        content.imageProperties.tintColor = .systemBlue
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ngo = pendingNGOs[indexPath.row]
        let detailVC = NGODetailViewController()
        detailVC.ngo = ngo
        detailVC.onDecision = { [weak self] ngoId in
            self?.removeNGO(withId: ngoId)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
