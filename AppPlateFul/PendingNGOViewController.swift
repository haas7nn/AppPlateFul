//
//  PeningNGOViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//

import UIKit

class PendingNGOListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Properties
    var pendingNGOs: [PendingNGO] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Pending NGO Verifications"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(closeTapped)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        
        filterButton.layer.cornerRadius = 8
    }
    
    private func loadData() {
        pendingNGOs = PendingNGO.sampleData
        updateUI()
    }
    
    private func updateUI() {
        tableView.reloadData()
        emptyStateLabel.isHidden = !pendingNGOs.isEmpty
        tableView.isHidden = pendingNGOs.isEmpty
    }
    
    // MARK: - Actions
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter", message: "Select option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All", style: .default) { [weak self] _ in
            self?.pendingNGOs = PendingNGO.sampleData
            self?.updateUI()
        })
        alert.addAction(UIAlertAction(title: "Highest Ratings", style: .default) { [weak self] _ in
            self?.pendingNGOs.sort { $0.ratingsCount > $1.ratingsCount }
            self?.updateUI()
        })
        alert.addAction(UIAlertAction(title: "Lowest Ratings", style: .default) { [weak self] _ in
            self?.pendingNGOs.sort { $0.ratingsCount < $1.ratingsCount }
            self?.updateUI()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    private func openDetail(for ngo: PendingNGO) {
        let storyboard = UIStoryboard(name: "PendingNGOs", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NGODetailViewController") as? NGODetailViewController {
            detailVC.ngo = ngo
            detailVC.onDecision = { [weak self] ngoId in
                self?.pendingNGOs.removeAll { $0.id == ngoId }
                self?.updateUI()
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension PendingNGOListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingNGOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell", for: indexPath)
        let ngo = pendingNGOs[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = ngo.name
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        content.secondaryText = ngo.status
        content.secondaryTextProperties.color = .systemOrange
        content.image = UIImage(systemName: "building.2.crop.circle.fill")
        content.imageProperties.tintColor = .systemBlue
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PendingNGOListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openDetail(for: pendingNGOs[indexPath.row])
    }
}
