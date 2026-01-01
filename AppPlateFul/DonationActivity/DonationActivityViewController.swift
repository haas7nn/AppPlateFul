//
//  DonationActivityViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 27/12/2025.
//

// DonationActivityViewController.swift

import UIKit

class DonationActivityViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Properties
    private var donations: [Donation] = []
    private var currentFilter: FilterOption = .all
    private var filterButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 12)
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
        emptyStateLabel.isHidden = !donations.isEmpty
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDonationDetail",
           let detailVC = segue.destination as? DonationDetailViewController,
           let donation = sender as? Donation {
            detailVC.donation = donation
        }
    }
    
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DonationActivityCell", for: indexPath
        ) as? DonationActivityCell else {
            return UITableViewCell()
        }
        
        let donation = donations[indexPath.row]
        cell.configure(with: donation)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donation = donations[indexPath.row]
        performSegue(withIdentifier: "showDonationDetail", sender: donation)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

// MARK: - DonationActivityCellDelegate
extension DonationActivityViewController: DonationActivityCellDelegate {
    func didTapReport(for donation: Donation) {
        showReportConfirmation(for: donation)
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
