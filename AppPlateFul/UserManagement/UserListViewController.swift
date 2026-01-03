//
//  UserListViewController.swift
//  AppPlateFul
//
//  202301686 - Hasan
//

import UIKit
import FirebaseFirestore

// Displays and manages the list of users retrieved from Firebase
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
    var isSearching: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Management"
        setupBackButton()
        setupTableView()
        fixTableViewConstraints()
        
        emptyStateLabel.text = "Loading users..."
        emptyStateLabel.isHidden = false
        
        fetchUsers()
    }
    
    // MARK: - Setup
    // Configures table view delegate and data source
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Ensures table view is correctly constrained below UI controls
    private func fixTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor: NSLayoutYAxisAnchor
        let topConstant: CGFloat
        
        if let segmentedControl = segmentedControl {
            topAnchor = segmentedControl.bottomAnchor
            topConstant = 8
        } else if let searchBar = searchBar {
            topAnchor = searchBar.bottomAnchor
            topConstant = 8
        } else {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
            topConstant = 0
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Sets a custom back button for navigation
    private func setupBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Firebase
    // Fetches all users from Firestore
    private func fetchUsers() {
        UserService.shared.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    self.updateUI()
                    
                case .failure(let error):
                    self.emptyStateLabel.text = "Error: \(error.localizedDescription)"
                    self.emptyStateLabel.isHidden = false
                }
            }
        }
    }
    
    // MARK: - UI Updates
    // Updates empty state and reloads table view
    private func updateUI() {
        emptyStateLabel.isHidden = !users.isEmpty
        emptyStateLabel.text = users.isEmpty ? "No users found" : ""
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    // Navigates to user detail screen
    private func navigateToDetails(for indexPath: IndexPath) {
        let displayUsers = isSearching ? filteredUsers : users
        
        guard let detailVC = storyboard?.instantiateViewController(
            withIdentifier: "UserDetailsViewController"
        ) as? UserDetailsViewController else {
            return
        }
        
        detailVC.user = displayUsers[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredUsers.count : users.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "UserCell",
            for: indexPath
        ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let displayUsers = isSearching ? filteredUsers : users
        let user = displayUsers[indexPath.row]
        
        cell.configure(
            name: user.displayName,
            status: user.status ?? "-",
            isStarred: user.isFavorite ?? false
        )
        
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        80
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetails(for: indexPath)
    }
}

// MARK: - UserCellDelegate
extension UserListViewController: UserCellDelegate {
    
    func didTapInfoButton(at indexPath: IndexPath) {
        navigateToDetails(for: indexPath)
    }
    
    func didTapStarButton(at indexPath: IndexPath) {
        let user = users[indexPath.row]
        let newFavorite = !(user.isFavorite ?? false)
        
        users[indexPath.row].isFavorite = newFavorite
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        UserService.shared.updateFavorite(
            userId: user.id,
            isFavorite: newFavorite
        ) { _ in }
    }
}
