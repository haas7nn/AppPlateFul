//
//  NGOReviewListViewController.swift
//  AppPlateFul
//

import UIKit

class NGOReviewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Properties
    var ngoList: [NGOReviewItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NGO Review"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(closeTapped)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        
        loadData()
        debugCheckImages()
    }
    
    // MARK: - Actions
    @objc func closeTapped() {
        dismiss(animated: true)
    }
    
    // MARK: - Data
    func loadData() {
        ngoList = NGOReviewItem.sampleData
        tableView.reloadData()
        emptyStateLabel.isHidden = !ngoList.isEmpty
    }
    
    // Debug: Check if images exist in Assets
    func debugCheckImages() {
        print("🔍 ========== CHECKING ASSETS ==========")
        for ngo in ngoList {
            if UIImage(named: ngo.logoName) != nil {
                print("✅ Found image: \(ngo.logoName)")
            } else {
                print("❌ NOT FOUND: \(ngo.logoName)")
            }
        }
        print("🔍 ======================================")
    }
    
    // MARK: - Navigation
    func openDetail(for ngo: NGOReviewItem) {
        let storyboard = UIStoryboard(name: "NGOReview", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NGOReviewDetailViewController") as? NGOReviewDetailViewController {
            detailVC.ngo = ngo
            detailVC.onDecision = { [weak self] ngoId in
                self?.ngoList.removeAll { $0.id == ngoId }
                self?.tableView.reloadData()
                self?.emptyStateLabel.isHidden = !(self?.ngoList.isEmpty ?? true)
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ngoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell", for: indexPath)
        let ngo = ngoList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = ngo.name
        content.secondaryText = ngo.status
        content.secondaryTextProperties.color = .systemOrange
        
        // Load from Assets first, fallback to system icon
        if let assetImage = UIImage(named: ngo.logoName) {
            content.image = assetImage
            content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            content.imageProperties.cornerRadius = 10
        } else {
            content.image = UIImage(systemName: "building.2.crop.circle.fill")
            content.imageProperties.tintColor = .systemBlue
        }
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openDetail(for: ngoList[indexPath.row])
    }
}
