import UIKit
import FirebaseAuth

final class SignupViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addDismissKeyboardTap()
    }

    // MARK: - UI Setup
    private func configureUI() {
        view.backgroundColor = .systemBackground

        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress

        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .newPassword
    }

    private func addDismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions
    @IBAction private func didTapCreateAccount(_ sender: UIButton) {
        let email = (emailTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text ?? ""

        guard isValidEmail(email) else {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }

        guard password.count >= 6 else {
            showAlert(title: "Invalid Password", message: "Password must be at least 6 characters long.")
            return
        }

        sender.isEnabled = false

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                sender.isEnabled = true

                if let error = error {
                    self?.showAlert(title: "Signup Failed", message: error.localizedDescription)
                    return
                }

                self?.navigateToProfile()
            }
        }
    }

    @IBAction private func didTapBackToLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation
    private func navigateToProfile() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        navigationController?.setViewControllers([profileVC], animated: true)
    }

    // MARK: - Helpers
    private func isValidEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

