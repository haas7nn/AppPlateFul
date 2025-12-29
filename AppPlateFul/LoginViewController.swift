import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        passwordTextField.isSecureTextEntry = true
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress

        // Hide  keyboard when tapping outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction private func didTapLogin(_ sender: UIButton) {
        let email = (emailTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text ?? ""

        guard email.contains("@"), email.contains(".") else {
            showAlert("Please enter a valid email address.")
            return
        }

        guard password.count >= 6 else {
            showAlert("Password must be at least 6 characters.")
            return
        }

        sender.isEnabled = false

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                sender.isEnabled = true

                if let error = error {
                    self?.showAlert(error.localizedDescription)
                    return
                }

                self?.goToProfile()
            }
        }
    }
    @IBAction func Login(_ sender: Any) {
    }
    
    private func goToProfile() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ProfileViewController")
        navigationController?.setViewControllers([vc], animated: true)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


