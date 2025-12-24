//
//  PendingNGOListViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

// MARK: - NGODetailDelegate Protocol
protocol NGODetailDelegate: AnyObject {
    func didApproveNGO(at index: Int)
    func didRejectNGO(at index: Int)
}

class PendingNGOListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Properties
    var ngos: [NGO] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateEmptyState()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Pending NGO Verifications"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filterButton.layer.cornerRadius = 8
    }
    
    private func loadData() {
        ngos = NGO.sampleNGOs.filter { $0.status == .pending }
        tableView.reloadData()
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        emptyStateLabel.isHidden = !ngos.isEmpty
    }
    
    // MARK: - Actions
    @IBAction func filterTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter", message: "Select filter option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Newest First", style: .default) { _ in
            // Sort by newest
        })
        alert.addAction(UIAlertAction(title: "Oldest First", style: .default) { _ in
            // Sort by oldest
        })
        alert.addAction(UIAlertAction(title: "Highest Rated", style: .default) { _ in
            self.ngos.sort { $0.ratingsCount > $1.ratingsCount }
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToDetail(with ngo: NGO, at index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NGODetailViewController") as? NGODetailViewController {
            detailVC.ngo = ngo
            detailVC.ngoIndex = index
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension PendingNGOListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ngos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell", for: indexPath) as? NGOTableViewCell else {
            return UITableViewCell()
        }
        
        let ngo = ngos[indexPath.row]
        cell.configure(with: ngo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ngo = ngos[indexPath.row]
        navigateToDetail(with: ngo, at: indexPath.row)
    }
}

// MARK: - NGODetailDelegate
extension PendingNGOListViewController: NGODetailDelegate {
    
    func didApproveNGO(at index: Int) {
        if index < ngos.count {
            ngos.remove(at: index)
            tableView.reloadData()
            updateEmptyState()
        }
    }
    
    func didRejectNGO(at index: Int) {
        if index < ngos.count {
            ngos.remove(at: index)
            tableView.reloadData()
            updateEmptyState()
        }
    }
}
