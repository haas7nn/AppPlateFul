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
