import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var verificationLabel: UILabel!
    
    @IBOutlet weak var donorTypeLabel: UILabel!
    @IBOutlet weak var donationsMadeLabel: UILabel!
    @IBOutlet weak var mealsProvidedLabel: UILabel!
    @IBOutlet weak var notificationsLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithUser()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Details"
        
        profileAvatar?.layer.cornerRadius = 50
        profileAvatar?.clipsToBounds = true
        profileAvatar?.tintColor = .systemGray2
        
        callButton?.layer.cornerRadius = 30
        callButton?.clipsToBounds = true
        emailButton?.layer.cornerRadius = 30
        emailButton?.clipsToBounds = true
        locationButton?.layer.cornerRadius = 30
        locationButton?.clipsToBounds = true
    }
    
    private func configureWithUser() {
        guard let user = user else {
            loadDefaultData()
            return
        }
        
        profileName?.text = user.name
        profileAvatar?.image = user.avatarImage ?? UIImage(systemName: "person.circle.fill")
        
        statusLabel?.text = user.status
        statusLabel?.textColor = user.status.lowercased() == "active" ? .systemGreen : .systemGray
        roleLabel?.text = user.role
        verificationLabel?.text = user.isVerified ? "Verified User" : "Not Verified"
        verificationLabel?.textColor = user.isVerified ? .systemBlue : .systemGray
        
        donorTypeLabel?.text = user.donorType
        donationsMadeLabel?.text = "\(user.donationsMade)"
        mealsProvidedLabel?.text = "\(user.mealsProvided)"
        notificationsLabel?.text = user.notificationsEnabled ? "Enabled" : "Disabled"
        notificationsLabel?.textColor = user.notificationsEnabled ? .systemGreen : .systemGray
        
        phoneLabel?.text = user.phone
        emailLabel?.text = user.email
        addressLabel?.text = user.address
    }
    
    private func loadDefaultData() {
        profileName?.text = "Abdulwahid"
        profileAvatar?.image = UIImage(systemName: "person.circle.fill")
        
        statusLabel?.text = "Active"
        statusLabel?.textColor = .systemGreen
        roleLabel?.text = "Donor"
        verificationLabel?.text = "Verified User"
        verificationLabel?.textColor = .systemBlue
        
        donorTypeLabel?.text = "Individual"
        donationsMadeLabel?.text = "18"
        mealsProvidedLabel?.text = "92"
        notificationsLabel?.text = "Enabled"
        notificationsLabel?.textColor = .systemGreen
        
        phoneLabel?.text = "+973 37282388"
        emailLabel?.text = "abdulwahid@gmail.com"
        addressLabel?.text = "Manama, Bahrain"
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Edit User", message: "Edit functionality coming soon.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        showAlert(title: "Call", message: "Calling \(phoneLabel?.text ?? "user")...")
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        showAlert(title: "Email", message: "Emailing \(emailLabel?.text ?? "user")...")
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        showAlert(title: "Location", message: "Opening maps for \(addressLabel?.text ?? "location")...")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
