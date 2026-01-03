import UIKit

class DonationListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var donationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderSummaryLabel: UILabel!
    
    // MARK: - Data passed from history
    var donation: DonationUpdate?
    
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
        orderSummaryLabel.text = donation.orderSummary
    }
    
    @IBAction func confirmDonationbutton(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Success",
            message: "Donation Confirmed ✅",
            preferredStyle: .alert
        )
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }
    }
}
