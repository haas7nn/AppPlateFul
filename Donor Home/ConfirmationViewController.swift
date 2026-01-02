import UIKit

class ConfirmationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var resumeButton: UIButton!
    // MARK: - Data from previous VC
    var selectedDate: String = ""
    var selectedFrequency: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequencyLabel.text = selectedFrequency
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        // Convert string → Date
        guard let startDate = formatter.date(from: selectedDate) else {
            dateLabel.text = selectedDate
            return
        }
        
        var finalDate: Date = startDate
        
        // ✅ Add time based on frequency
        if selectedFrequency == "Weekly" {
            finalDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? startDate
        } else if selectedFrequency == "Monthly" {
            finalDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate) ?? startDate
        }
        
        // Show calculated date
        //dateLabel.text = "Next Donation: \(endDateString)"
        dateLabel.text = "Next Donation in: \(formatter.string(from: finalDate))"
        
        // Button styling
        confirmButton.layer.cornerRadius = 10
        resumeButton.layer.cornerRadius = 10
        editButton.layer.cornerRadius = 10
        //confirmButton.backgroundColor = .systemBlue
        //confirmButton.setTitleColor(.white, for: .normal)
    }

    // MARK: - Confirm Button
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Paused",
            message: "Donation paused",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func resumeButtonTapped(_ sender: Any) {
        
            let alert = UIAlertController(
                title: "Resumed",
                message: "Donation Resumed",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
