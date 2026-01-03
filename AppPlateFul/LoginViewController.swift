import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerTabButton: UIButton!
    @IBOutlet weak var loginTabButton: UIButton!
    @IBOutlet weak var cardView: UIView!

    // MARK: - Firebase
    private let db = Firestore.firestore()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Setup UI
    private func setupUI() {
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 12

        styleTextField(emailTF, placeholder: "Email", icon: "envelope.fill")
        styleTextField(passTF, placeholder: "Password", icon: "lock.fill")
        passTF.isSecureTextEntry = true

        emailTF.autocapitalizationType = .none
        passTF.autocapitalizationType = .none

        loginButton.layer.cornerRadius = 16
        loginButton.layer.shadowColor = UIColor(red: 0.69, green: 0.77, blue: 0.61, alpha: 1).cgColor
        loginButton.layer.shadowOpacity = 0.4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.layer.shadowRadius = 8

        loginTabButton.layer.cornerRadius = 12
        registerTabButton.layer.cornerRadius = 12

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func styleTextField(_ textField: UITextField, placeholder: String, icon: String) {
        textField.layer.cornerRadius = 14
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        textField.backgroundColor = .white
        textField.clipsToBounds = true

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 0.7, alpha: 1)]
        )

        let iconView = UIImageView(frame: CGRect(x: 12, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = UIColor(red: 0.69, green: 0.77, blue: 0.61, alpha: 1)
        iconView.contentMode = .scaleAspectFit

        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 20))
        leftContainer.addSubview(iconView)

        textField.leftView = leftContainer
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 20))
        textField.rightViewMode = .always
        textField.rightViewMode = .always
    }

    @objc private func dismissKeyboard() { view.endEditing(true) }

    // MARK: - IBActions
    @IBAction func loginTapped(_ sender: UIButton) {
        animateButton(sender)

        let email = (emailTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = (passTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !email.isEmpty else {
            shakeRecognize(emailTF)
            return
        }

        guard !password.isEmpty else {
            shakeRecognize(passTF)
            return
        }

        sender.isEnabled = false

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self else { return }
            sender.isEnabled = true

            if let error = error {
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
                return
            }

            guard let uid = Auth.auth().currentUser?.uid else { return }

            self.showAlert(title: "Done ✅", message: "Logged in successfully!") { [weak self] in
                self?.routeUser(uid: uid)
            }
        }
    }

    // MARK: - Role Routing (NEW)
    private func routeUser(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] snap, err in
            guard let self else { return }

            if let err = err {
                self.showAlert(title: "Error", message: err.localizedDescription)
                return
            }

            let role = (snap?.data()?["role"] as? String)?.lowercased() ?? ""

            switch role {
            case "ngo":
                self.goToVC("NGOHomeVC")
            case "donor":
                self.goToVC("DonorHomeVC")
            case "admin":
                self.goToVC("AdminHomeVC")
            default:
                self.showAlert(title: "No Role", message: "Role not set for this user.")
            }
        }
    }

    private func goToVC(_ id: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    // MARK: - Navigation (OLD - keep if you want)
    private func goToHome() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let home = sb.instantiateViewController(withIdentifier: "HomeVC")
        home.modalPresentationStyle = .fullScreen
        present(home, animated: true)
    }

    // MARK: - Animations
    private func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) { button.transform = .identity }
        }
    }

    private func shakeRecognize(_ tf: UITextField) {
        shakeTextField(tf)
        showAlert(title: "Oops!", message: tf == emailTF ? "Please enter your email" : "Please enter your password")
    }

    private func shakeTextField(_ textField: UITextField) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-10, 10, -8, 8, -5, 5, -2, 2, 0]
        textField.layer.add(animation, forKey: "shake")

        textField.layer.borderColor = UIColor.systemRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            textField.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        }
    }

    // MARK: - Alert
    private func showAlert(title: String, message: String, onOk: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in onOk?() })
        present(alert, animated: true)
    }
}
