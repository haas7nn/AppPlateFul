import UIKit

class DonationUpdatesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var donationsStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDonationButtons()
    }

    // MARK: - Add actions to the buttons in the stack view
    func setupDonationButtons() {
        for row in donationsStackView.arrangedSubviews {
            if let button = row.viewWithTag(100) as? UIButton { // Details button
                button.addTarget(self,
                                 action: #selector(detailsButtonTapped(_:)),
                                 for: .touchUpInside)
            }
        }
    }

    // MARK: - Button tapped
    @objc func detailsButtonTapped(_ sender: UIButton) {
        guard let row = sender.superview else { return }

        var donationImage: UIImage?
        var name = ""
        var orderSummary = ""

        for subview in row.subviews {
            if let imageView = subview as? UIImageView {
                donationImage = imageView.image
            } else if let label = subview as? UILabel {
                switch label.tag {
                case 1:
                    name = label.text ?? ""
                case 2:
                    orderSummary = label.text ?? ""
                default:
                    break
                }
            }
        }

        let donation = DonationUpdate(
            image: donationImage,
            name: name,
            orderSummary: orderSummary
        )

        performSegue(withIdentifier: "goToDonationDetails", sender: donation)
    }

    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDonationDetails",
           let detailsVC = segue.destination as? DonationListViewController,
           let donation = sender as? DonationUpdate {
            
            detailsVC.donation = donation
        }
    }

    // MARK: - Filter Button Action
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Filter Donations",
            message: nil,
            preferredStyle: .actionSheet
        )

        alert.addAction(UIAlertAction(title: "All", style: .default) { _ in
            self.applyFilter(status: nil)
            sender.title = "Filter: All"
        })

        alert.addAction(UIAlertAction(title: "Completed", style: .default) { _ in
            self.applyFilter(status: "Completed")
            sender.title = "Filter: Completed"
        })

        alert.addAction(UIAlertAction(title: "Pending", style: .default) { _ in
            self.applyFilter(status: "Pending")
            sender.title = "Filter: Pending"
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if let popover = alert.popoverPresentationController {
            popover.barButtonItem = sender
        }

        present(alert, animated: true)
    }

    // MARK: - Apply Filter
    func applyFilter(status: String?) {
        for row in donationsStackView.arrangedSubviews {
            if let statusLabel = row.viewWithTag(3) as? UILabel {
                let statusText = statusLabel.text ?? ""
                row.isHidden = status != nil && statusText != status
            } else {
                row.isHidden = false
            }
        }
    }
}
