import UIKit

class PendingNGOsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!

    // dummy
    private let pendingNGOs: [PendingNGO] = [
        PendingNGO(
            name: "Islamic Hands",
            logoImage: UIImage(systemName: "hands.sparkles"),
            ratingsCount: 122,
            area: "Sitra, Bahrain",
            openingHours: "9:00 AM - 9:00 PM",
            avgPickupTime: "22 minutes",
            collectedDonations: "16 this month",
            pickupReliability: "100% on-time",
            communityReviews: "N/A"
        ),
        PendingNGO(
            name: "Salmonda Helps",
            logoImage: UIImage(systemName: "heart.circle"),
            ratingsCount: 89,
            area: "Manama, Bahrain",
            openingHours: "10:00 AM - 8:00 PM",
            avgPickupTime: "30 minutes",
            collectedDonations: "10 this month",
            pickupReliability: "95% on-time",
            communityReviews: "Good"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pending NGO Verifications"

        tableView.dataSource = self
        tableView.delegate = self

        updateEmptyState()
    }

    private func updateEmptyState() {
        let isEmpty = pendingNGOs.isEmpty
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }

    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filter",
                                      message: "Choose filter",
                                      preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "All", style: .default))
        alert.addAction(UIAlertAction(title: "Newest", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if let pop = alert.popoverPresentationController {
            pop.barButtonItem = sender
        }

        present(alert, animated: true)
    }
}

extension PendingNGOsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return pendingNGOs.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell",
                                                 for: indexPath)

        let ngo = pendingNGOs[indexPath.row]

        cell.textLabel?.text = ngo.name
        cell.detailTextLabel?.text = "Pending Verification"
        cell.imageView?.image = ngo.logoImage
        cell.imageView?.tintColor = .systemGray
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

extension PendingNGOsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedNGO = pendingNGOs[indexPath.row]

        let sb = UIStoryboard(name: "PendingNGOs", bundle: nil)
        let vc = sb.instantiateViewController(
            withIdentifier: "NGODetailViewController"
        ) as! NGODetailViewController

        vc.ngo = selectedNGO

        navigationController?.pushViewController(vc, animated: true)
    }
}
