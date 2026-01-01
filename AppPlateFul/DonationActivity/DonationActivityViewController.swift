//
// DonationActivityViewController.swift
// AppPlateFul
//

import UIKit

class DonationActivityViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel?
    
    // MARK: - Properties
    private var donations: [Donation] = []
    private var currentFilter: FilterOption = .all
    private var filterButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🚀 DonationActivityViewController loaded")
        setupUI()
        setupFilterButton()
        setupNotifications()
        loadDonations()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = DonationTheme.backgroundColor
        tableView.backgroundColor = DonationTheme.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 20, right: 0)
        
        // ✅ Register cell class as fallback
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DonationCell")
        
        print("✅ TableView setup complete")
    }
    
    private func setupFilterButton() {
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter ", for: .normal)
        filterButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        filterButton.semanticContentAttribute = .forceRightToLeft
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        filterButton.tintColor = DonationTheme.textPrimary
        filterButton.backgroundColor = .white
        filterButton.layer.cornerRadius = 16
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 12)
        filterButton.configuration = config
        
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        
        let filterBarButton = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleStatusUpdate),
            name: .donationStatusUpdated, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleDonationReported),
            name: .donationReported, object: nil
        )
    }
    
    // MARK: - Data
    private func loadDonations() {
        donations = DonationDataProvider.shared.filteredDonations(by: currentFilter)
        print("📊 Loaded \(donations.count) donations")
        emptyStateLabel?.isHidden = !donations.isEmpty
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func homeTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func filterTapped() {
        let filterVC = FilterPopupViewController(currentFilter: currentFilter)
        filterVC.delegate = self
        filterVC.modalPresentationStyle = .overCurrentContext
        filterVC.modalTransitionStyle = .crossDissolve
        present(filterVC, animated: true)
    }
    
    @objc private func handleStatusUpdate(_ notification: Notification) {
        loadDonations()
    }
    
    @objc private func handleDonationReported(_ notification: Notification) {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    private func showReportConfirmation(for donation: Donation) {
        let popup = ReportConfirmationPopup()
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        popup.onConfirm = { [weak self] in
            DonationDataProvider.shared.reportDonation(donationId: donation.id)
            self?.showReportedAlert()
        }
        present(popup, animated: true)
    }
    
    private func showReportedAlert() {
        let alert = StatusUpdatedPopup(
            icon: UIImage(systemName: "exclamationmark.triangle.fill"),
            message: "Donation Reported",
            iconColor: .systemOrange
        )
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true)
            }
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension DonationActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let donation = donations[indexPath.row]
        
        // Use basic cell with default configuration (works without storyboard cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = donation.ngoName
        content.secondaryText = "\(donation.status.rawValue) • \(donation.formattedCreatedDate)"
        content.secondaryTextProperties.color = donation.status.color
        content.image = donation.ngoLogo ?? UIImage(systemName: "building.2.fill")
        content.imageProperties.maximumSize = CGSize(width: 60, height: 60)
        content.imageProperties.cornerRadius = 10
        content.imageProperties.tintColor = DonationTheme.primaryBrown
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = DonationTheme.cardBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let donation = donations[indexPath.row]
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DonationDetailViewController") as? DonationDetailViewController else {
            print("❌ Could not find DonationDetailViewController")
            return
        }
        
        detailVC.donation = donation
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - FilterPopupDelegate
extension DonationActivityViewController: FilterPopupDelegate {
    func didSelectFilter(_ filter: FilterOption) {
        currentFilter = filter
        filterButton.setTitle("\(filter.rawValue) ", for: .normal)
        loadDonations()
    }
}
