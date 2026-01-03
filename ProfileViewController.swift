import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var editButton: UIButton! // Add a button to open edit screen

    // MARK: - Profile Data
    var profileImage: UIImage?
    var fullName: String = ""
    var email: String = ""
    var phone: String = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        // Set labels
        nameLabel.text = "Full Name: \(fullName)"
        emailLabel.text = "Email: \(email)"
        phoneLabel.text = "Phone: \(phone)"
        
        // Set profile image
        if let image = profileImage {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(systemName: "person.circle") // placeholder
        }

        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        // Style edit button
        //editButton.layer.cornerRadius = 10
        //editButton.backgroundColor = .systemBlue
        //editButton.setTitleColor(.white, for: .normal)
    }

    // MARK: - Edit Button Action
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else {
            print("EditProfileViewController not found in storyboard")
            return
        }

        // Pass existing data to prefill edit screen
        editVC.existingProfileImage = profileImage
        editVC.existingFullName = fullName
        editVC.existingEmail = email
        editVC.existingPhone = phone

        navigationController?.pushViewController(editVC, animated: true)
    }

    // Optional: Update UI if returning from Edit screen via viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh labels and image in case they were updated
        nameLabel.text = "Full Name: \(fullName)"
        emailLabel.text = "Email: \(email)"
        phoneLabel.text = "Phone: \(phone)"
        profileImageView.image = profileImage
    }
}
