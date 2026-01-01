import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    var users: [User] = User.sampleUsers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Management"
        tableView.delegate = self
        tableView.dataSource = self
        emptyStateLabel.isHidden = !users.isEmpty
        
        // DEBUG: Check navigation controller
        print("DEBUG viewDidLoad: navigationController = \(String(describing: navigationController))")
    }
    
    private func navigateToDetails(for indexPath: IndexPath) {
        print("DEBUG: navigateToDetails called for row \(indexPath.row)")
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController else {
            print("DEBUG: FAILED to create UserDetailsViewController!")
            return
        }
        
        print("DEBUG: DetailVC created successfully")
        
        detailVC.user = users[indexPath.row]
        
        print("DEBUG: navigationController = \(String(describing: navigationController))")
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        print("DEBUG: Push called")
    }
}

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
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Row \(indexPath.row) tapped")
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetails(for: indexPath)
    }
}

extension UserListViewController: UserCellDelegate {
    func didTapInfoButton(at indexPath: IndexPath) {
        print("DEBUG: Info button tapped for row \(indexPath.row)")
        navigateToDetails(for: indexPath)
    }
    
    func didTapStarButton(at indexPath: IndexPath) {
        print("DEBUG: Star button tapped for row \(indexPath.row)")
        users[indexPath.row].isFavorite.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
