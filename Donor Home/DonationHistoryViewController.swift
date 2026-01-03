import UIKit

class DonationHistoryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var donationsStackView: UIStackView! // Stack view in storyboard
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDonationButtons()
    }
    

    // MARK: - Add actions to the buttons in the stack view
    func setupDonationButtons() {
        for row in donationsStackView.arrangedSubviews {
            if let button = row.viewWithTag(100) as? UIButton { // Tag 100 = Details button
                button.addTarget(self, action: #selector(detailsButtonTapped(_:)), for: .touchUpInside)
            }
        }
    }
    
    
    

    // MARK: - Button tapped
    @objc func detailsButtonTapped(_ sender: UIButton) {
        // Find the parent row of this button
        guard let row = sender.superview else { return }

        // Extract data from labels inside the row
        var donationImage: UIImage? = nil
        var name = ""
        var date = ""
        var status = ""
        var orderSummary = "" // optional if you want

        // Loop through row subviews
        for subview in row.subviews {
            if let imageView = subview as? UIImageView {
                donationImage = imageView.image
            } else if let label = subview as? UILabel {
                switch label.tag {
                case 1: name = label.text ?? ""
                case 2: date = label.text ?? ""
                case 3: status = label.text ?? ""
                case 4: orderSummary = label.text ?? "" // if you have a label for summary
                default: break
                }
            }
        }

        // Create a Donation object
        let donation = Donation(image: donationImage, name: name, date: date, orderSummary: orderSummary, status: status)
        performSegue(withIdentifier: "goToDonationDetails", sender: donation)
    }

    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDonationDetails",
           let detailsVC = segue.destination as? DonationDetailsViewController,
           let donation = sender as? Donation {
            detailsVC.donation = donation
        }
    }
    
    
    // MARK: - Filter button action
    // MARK: - Filter Button Action
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filter Donations", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All", style: .default, handler: { _ in
            self.applyFilter(status: nil)
            sender.title = "Filter: All"
        }))
        
        alert.addAction(UIAlertAction(title: "Completed", style: .default, handler: { _ in
            self.applyFilter(status: "Completed")
            sender.title = "Filter: Completed"
        }))
        
        alert.addAction(UIAlertAction(title: "Pending", style: .default, handler: { _ in
            self.applyFilter(status: "Pending")
            sender.title = "Filter: Pending"
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // iPad support
        if let popover = alert.popoverPresentationController {
            popover.barButtonItem = sender
        }
        
        present(alert, animated: true)
    }

    // MARK: - Apply Filter
    func applyFilter(status: String?) {
        for row in donationsStackView.arrangedSubviews {
            // Find the label with tag 3 (status label)
            if let statusLabel = row.viewWithTag(3) as? UILabel {
                if let statusText = statusLabel.text {
                    // Show all if no filter, else hide rows that don’t match
                    row.isHidden = status != nil && statusText != status
                } else {
                    row.isHidden = true
                }
            } else {
                row.isHidden = false
            }
        }
    }
}





