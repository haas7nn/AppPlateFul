//
// UserListViewController.swift
// AppPlateFul
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
    var users: [User] = User.sampleUsers
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "User Management"
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hide empty state if we have data
        emptyStateLabel.isHidden = !users.isEmpty
    }
}

// MARK: - UITableViewDelegate & DataSource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        cell.configure(name: user.name, status: user.status, isStarred: user.isFavorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController else {
            return
        }
        
        // Pass user data if needed
        // detailVC.user = users[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
