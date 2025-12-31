import UIKit

final class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var roleTF: UITextField!

    @IBOutlet weak var nameErr: UILabel!
    @IBOutlet weak var emailErr: UILabel!
    @IBOutlet weak var phoneErr: UILabel!
    @IBOutlet weak var roleErr: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrors()
    }

    @IBAction func didTapSave(_ sender: UIButton) {
        hideErrors()

        if (nameTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            show(nameTF, nameErr, "Please enter your full name.")
            return
        }

        let email = (emailTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if !email.contains("@") {
            show(emailTF, emailErr, "Please enter a valid email.")
            return
        }

        let phone = (phoneTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if phone.count != 8 || phone.contains(where: { !$0.isNumber }) {
            show(phoneTF, phoneErr, "Phone must be 8 digits.")
            return
        }

        if (roleTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            show(roleTF, roleErr, "Please specify your role.")
            return
        }

        // success alert
        let alert = UIAlertController(
            title: nil,
            message: "Your information has been saved successfully",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    private func show(_ tf: UITextField, _ label: UILabel, _ msg: String) {
        label.text = msg
        label.isHidden = false
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemRed.cgColor
        tf.layer.cornerRadius = 8
    }

    private func hideErrors() {
        [nameErr, emailErr, phoneErr, roleErr].forEach { $0?.isHidden = true }
        [nameTF, emailTF, phoneTF, roleTF].forEach {
            $0?.layer.borderWidth = 0
            $0?.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
