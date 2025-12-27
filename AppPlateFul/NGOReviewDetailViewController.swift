import UIKit

class NGOReviewDetailViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var areaValueLabel: UILabel!
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var pickupTimeValueLabel: UILabel!
    @IBOutlet weak var donationsValueLabel: UILabel!
    @IBOutlet weak var reliabilityValueLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    var ngo: NGOReviewItem?
    var onDecision: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NGO Detail"
        
        logoImageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        logoImageView.layer.cornerRadius = 35
        logoImageView.clipsToBounds = true
        
        approveButton.layer.cornerRadius = 10
        rejectButton.layer.cornerRadius = 10
        
        guard let ngo = ngo else { return }
        
        nameLabel.text = ngo.name
        statusLabel.text = ngo.status
        areaValueLabel.text = "Area: \(ngo.area)"
        hoursValueLabel.text = "Hours: \(ngo.openingHours)"
        pickupTimeValueLabel.text = "Pickup: \(ngo.avgPickupTime)"
        donationsValueLabel.text = "Donations: \(ngo.collectedDonations)"
        reliabilityValueLabel.text = "Reliability: \(ngo.pickupReliability)"
        reviewsValueLabel.text = "Reviews: \(ngo.communityReviews)"
    }
    
    @IBAction func approveButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Approve", message: "Approve this NGO?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Approve", style: .default) { [weak self] _ in
            self?.showSuccess(approved: true)
        })
        present(alert, animated: true)
    }
    
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reject", message: "Reject this NGO?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reject", style: .destructive) { [weak self] _ in
            self?.showSuccess(approved: false)
        })
        present(alert, animated: true)
    }
    
    func showSuccess(approved: Bool) {
        let title = approved ? "Approved!" : "Rejected!"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let id = self?.ngo?.id {
                self?.onDecision?(id)
            }
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
