import UIKit

class DonationDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var donationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderSummaryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    // MARK: - Data passed from history
    var donation: Donation?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let donation = donation else { return }

        // Image
        if let image = donation.image {
            donationImageView.image = image
            donationImageView.contentMode = .scaleAspectFill
            donationImageView.clipsToBounds = true
            donationImageView.layer.cornerRadius = donationImageView.frame.width / 2
        }

        // Labels
        nameLabel.text = donation.name
        dateLabel.text = donation.date
        orderSummaryLabel.text = donation.orderSummary
        statusLabel.text = donation.status
    }
}
