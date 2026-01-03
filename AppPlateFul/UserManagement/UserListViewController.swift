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
        setupBackButton()

        tableView.delegate = self
        tableView.dataSource = self

        emptyStateLabel.isHidden = !users.isEmpty
    }

    // MARK: - Back Button
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

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation
    private func navigateToDetails(for indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(
            withIdentifier: "UserDetailsViewController"
        ) as? UserDetailsViewController else {
            return
        }

        detailVC.user = users[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TableView
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
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

        let user = users[indexPath.row]
        cell.configure(with: user)
        cell.delegate = self
        cell.indexPath = indexPath

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetails(for: indexPath)
    }
}

// MARK: - Cell Delegate
extension UserListViewController: UserCellDelegate {

    func didTapInfoButton(at indexPath: IndexPath) {
        navigateToDetails(for: indexPath)
    }

    func didTapStarButton(at indexPath: IndexPath) {
        users[indexPath.row].isFavorite.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
