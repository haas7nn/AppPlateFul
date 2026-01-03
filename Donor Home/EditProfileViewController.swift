import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    // Placeholder label for "Edit Picture"
    private let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Picture"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Existing data passed from previous view
    var existingFullName: String?
    var existingEmail: String?
    var existingPhone: String?
    var existingProfileImage: UIImage?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImageView()
        setupTextFields()
        styleSaveButton()
        
        // Populate fields with existing data
        fullNameTextField.text = existingFullName
        emailTextField.text = existingEmail
        phoneTextField.text = existingPhone
        profileImageView.image = existingProfileImage

        // Optional: Hide "Edit Picture" placeholder if image exists
        if existingProfileImage != nil {
            profileImageView.layer.borderWidth = 0
        } else {
            // Add border or placeholder text if you want
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Make the profile image perfectly circular
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

    // MARK: - Setup Profile Image
    func setupProfileImageView() {
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        // Add tap gesture to edit image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)

        // Add placeholder label
        profileImageView.addSubview(editLabel)
        NSLayoutConstraint.activate([
            editLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            editLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }

    @objc func editProfileImage() {
        let alert = UIAlertController(title: "Edit Profile Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }

    // MARK: - Camera & Library
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func openPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    // MARK: - UIImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        var selectedImage: UIImage?
        if let edited = info[.editedImage] as? UIImage {
            selectedImage = edited
        } else if let original = info[.originalImage] as? UIImage {
            selectedImage = original
        }
        
        if let image = selectedImage {
            profileImageView.image = image
            editLabel.isHidden = true // hide "Edit Picture" once an image is chosen
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    // MARK: - Setup TextFields
    func setupTextFields() {
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self

        fullNameTextField.keyboardType = .default
        emailTextField.keyboardType = .emailAddress
        phoneTextField.keyboardType = .numberPad
    }

    // MARK: - Save Button Styling
    func styleSaveButton() {
        saveButton.layer.cornerRadius = 10
        //saveButton.backgroundColor = UIColor.systemBlue
        //saveButton.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Validation Functions

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPhone(_ phone: String) -> Bool {
        // Allow only numbers, and typically 7-15 digits for phone numbers
        let phoneRegEx = "^[0-9]{7,15}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
    }

    // MARK: - Save Action
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        
        
        
        // MARK: - Save Action
        
        /*    guard let fullName = fullNameTextField.text, !fullName.isEmpty,
                  let email = emailTextField.text, !email.isEmpty,
                  let phone = phoneTextField.text, !phone.isEmpty else {
                let alert = UIAlertController(title: "Error", message: "All fields are required.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            // Validate email
            if !isValidEmail(email) {
                let alert = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            // Validate phone (numbers only)
            if !isValidPhone(phone) {
                let alert = UIAlertController(title: "Error", message: "Please enter a valid phone number.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }

            // Placeholder: Save profile info here
            print("Full Name: \(fullName), Email: \(email), Phone: \(phone)")
            
            let successAlert = UIAlertController(title: "Saved", message: "Profile updated successfully.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(successAlert, animated: true)
        }

        // MARK: - Validation Helpers
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }

        func isValidPhone(_ phone: String) -> Bool {
            let phoneRegEx = "^[0-9]{6,15}$" // Allows 6–15 digits
            let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            return phonePred.evaluate(with: phone) */
        
        
        
        
        
            guard let fullName = fullNameTextField.text, !fullName.isEmpty,
                  let email = emailTextField.text, !email.isEmpty,
                  let phone = phoneTextField.text, !phone.isEmpty else {
                let alert = UIAlertController(title: "Error", message: "All fields are required.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            if !isValidEmail(email) {
                let alert = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            if !isValidPhone(phone) {
                let alert = UIAlertController(title: "Error", message: "Please enter a valid phone number.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }

            // Navigate to ProfileViewController and pass the data
            if let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                profileVC.fullName = fullName
                profileVC.email = email
                profileVC.phone = phone
                profileVC.profileImage = profileImageView.image // Pass the image
                navigationController?.pushViewController(profileVC, animated: true)
            }
        
            
        }
        
    }

