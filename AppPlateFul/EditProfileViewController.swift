import UIKit
import FirebaseAuth

final class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!

    @IBOutlet weak var nameErr: UILabel!
    @IBOutlet weak var emailErr: UILabel!
    @IBOutlet weak var phoneErr: UILabel!

    @IBOutlet weak var saveBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideErrors()

        [nameTF, emailTF, phoneTF].forEach {
            $0?.addTarget(self, action: #selector(checkField(_:)), for: .editingDidEnd)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleSaveButton() // To make it fully rounded
    }

    private func setupUI() {
        styleField(nameTF)
        styleField(emailTF)
        styleField(phoneTF)
        styleSaveButton()
    }

    private func styleField(_ tf: UITextField) {
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 1.5
        tf.layer.borderColor = UIColor(white: 0.88, alpha: 1).cgColor
        tf.clipsToBounds = true
    }

    private func styleSaveButton() {
        saveBtn.layer.cornerRadius = saveBtn.bounds.height / 2
        saveBtn.layer.masksToBounds = false
        saveBtn.clipsToBounds = false

        saveBtn.layer.shadowColor = UIColor.black.cgColor
        saveBtn.layer.shadowOpacity = 0.12
        saveBtn.layer.shadowRadius = 14
        saveBtn.layer.shadowOffset = CGSize(width: 0, height: 8)
    }

    private func hideErrors() {
        [nameErr, emailErr, phoneErr].forEach { $0?.isHidden = true }
        reset(nameTF); reset(emailTF); reset(phoneTF)
    }

    private func reset(_ tf: UITextField) {
        tf.layer.borderColor = UIColor(white: 0.88, alpha: 1).cgColor
    }

    private func showError(tf: UITextField, label: UILabel, msg: String) {
        label.text = msg
        label.isHidden = false
        tf.layer.borderColor = UIColor.systemRed.cgColor
    }

    @objc private func checkField(_ sender: UITextField) {
        // Turns red if the user leaves it empty
        if sender == nameTF { nameErr.isHidden = true; reset(nameTF) }
        if sender == emailTF { emailErr.isHidden = true; reset(emailTF) }
        if sender == phoneTF { phoneErr.isHidden = true; reset(phoneTF) }

        let text = (sender.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            if sender == nameTF { showError(tf: nameTF, label: nameErr, msg: "Please enter your full name.") }
            if sender == emailTF { showError(tf: emailTF, label: emailErr, msg: "Please enter a valid email address.") }
            if sender == phoneTF { showError(tf: phoneTF, label: phoneErr, msg: "Your phone number must be 8 digits.") }
        }
    }

    @IBAction func didTapSave(_ sender: UIButton) {
        hideErrors()

        let name = (nameTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let email = (emailTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = (phoneTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        var ok = true

        if name.isEmpty { showError(tf: nameTF, label: nameErr, msg: "Please enter your full name."); ok = false }
        if email.isEmpty { showError(tf: emailTF, label: emailErr, msg: "Please enter a valid email address."); ok = false }
        if phone.isEmpty { showError(tf: phoneTF, label: phoneErr, msg: "Your phone number must be 8 digits."); ok = false }

        guard ok else { return }

        let alert = UIAlertController(title: "Saved ✅", message: "Your profile has been updated.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
