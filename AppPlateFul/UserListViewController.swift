//
//  UserListViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 24/12/2025.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Properties
    var users: [User] = []
    var filteredUsers: [User] = []
    var isSearching = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "User Management"
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filterButton.layer.cornerRadius = 8
    }
    
    private func loadSampleData() {
        users = [
            User(name: "Abdulwahid", status: "Active", isFavorite: true),
            User(name: "Zahra Ali", status: "Active", isFavorite: false),
            User(name: "Hussein Mohammed", status: "Inactive", isFavorite: true),
            User(name: "Ahmed Ali", status: "Active", isFavorite: false)
        ]
        filteredUsers = users
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter", message: "Select filter option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "All", style: .default))
        alert.addAction(UIAlertAction(title: "Active", style: .default))
        alert.addAction(UIAlertAction(title: "Inactive", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isSearching ? filteredUsers.count : users.count
        emptyStateLabel.isHidden = count > 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.configure(with: user)
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetails(at: indexPath)
    }
    
    private func navigateToDetails(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
            detailsVC.user = user
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension UserListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredUsers = users
        } else {
            isSearching = true
            filteredUsers = users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredUsers = users
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}

// MARK: - UserCellDelegate
extension UserListViewController: UserCellDelegate {
    
    func didTapInfoButton(at indexPath: IndexPath) {
        navigateToDetails(at: indexPath)
    }
    
    func didTapStarButton(at indexPath: IndexPath) {
        if isSearching {
            filteredUsers[indexPath.row].isFavorite.toggle()
        } else {
            users[indexPath.row].isFavorite.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
