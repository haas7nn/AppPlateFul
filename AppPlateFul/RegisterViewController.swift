import UIKit
<<<<<<< HEAD

class RegisterViewController: UIViewController {
    
=======
import FirebaseAuth

final class RegisterViewController: UIViewController {

>>>>>>> origin/dev
    // MARK: - IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginTabButton: UIButton!
    @IBOutlet weak var registerTabButton: UIButton!
    @IBOutlet weak var cardView: UIView!
<<<<<<< HEAD
    
=======

>>>>>>> origin/dev
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
<<<<<<< HEAD
    
=======

>>>>>>> origin/dev
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
<<<<<<< HEAD
    
    // MARK: - Setup UI
    private func setupUI() {
        // Card View
=======

    // MARK: - Setup UI
    private func setupUI() {
>>>>>>> origin/dev
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 12
<<<<<<< HEAD
        
        // Text Fields
=======

>>>>>>> origin/dev
        styleTextField(nameTF, placeholder: "Full Name", icon: "person.fill")
        styleTextField(emailTF, placeholder: "Email", icon: "envelope.fill")
        styleTextField(passTF, placeholder: "Password", icon: "lock.fill")
        styleTextField(confirmTF, placeholder: "Confirm Password", icon: "lock.shield.fill")
<<<<<<< HEAD
        
        passTF.isSecureTextEntry = true
        confirmTF.isSecureTextEntry = true
        
        // Register Button
=======

        passTF.isSecureTextEntry = true
        confirmTF.isSecureTextEntry = true

        emailTF.autocapitalizationType = .none
        passTF.autocapitalizationType = .none
        confirmTF.autocapitalizationType = .none

>>>>>>> origin/dev
        registerButton.layer.cornerRadius = 16
        registerButton.layer.shadowColor = UIColor(red: 0.69, green: 0.77, blue: 0.61, alpha: 1).cgColor
        registerButton.layer.shadowOpacity = 0.4
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        registerButton.layer.shadowRadius = 8
<<<<<<< HEAD
        
        // Tab Buttons
        loginTabButton.layer.cornerRadius = 12
        registerTabButton.layer.cornerRadius = 12
        
        // Dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
=======

        loginTabButton.layer.cornerRadius = 12
        registerTabButton.layer.cornerRadius = 12

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

>>>>>>> origin/dev
    private func styleTextField(_ textField: UITextField, placeholder: String, icon: String) {
        textField.layer.cornerRadius = 14
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        textField.backgroundColor = .white
        textField.clipsToBounds = true
<<<<<<< HEAD
        
=======

>>>>>>> origin/dev
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 0.7, alpha: 1)]
        )
<<<<<<< HEAD
        
=======

>>>>>>> origin/dev
        let iconView = UIImageView(frame: CGRect(x: 12, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = UIColor(red: 0.69, green: 0.77, blue: 0.61, alpha: 1)
        iconView.contentMode = .scaleAspectFit
<<<<<<< HEAD
        
        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 20))
        leftContainer.addSubview(iconView)
        
=======

        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 20))
        leftContainer.addSubview(iconView)

>>>>>>> origin/dev
        textField.leftView = leftContainer
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 20))
        textField.rightViewMode = .always
    }
<<<<<<< HEAD
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func registerTapped(_ sender: UIButton) {
        animateButton(sender)
        
        guard let name = nameTF.text, !name.isEmpty else {
            shakeTextField(nameTF)
            showAlert(title: "Oops!", message: "Please enter your name")
            return
        }
        
        guard let email = emailTF.text, !email.isEmpty, email.contains("@") else {
            shakeTextField(emailTF)
            showAlert(title: "Oops!", message: "Please enter a valid email")
            return
        }
        
        guard let password = passTF.text, password.count >= 6 else {
            shakeTextField(passTF)
            showAlert(title: "Oops!", message: "Password must be at least 6 characters")
            return
        }
        
        guard let confirm = confirmTF.text, confirm == password else {
            shakeTextField(confirmTF)
            showAlert(title: "Oops!", message: "Passwords do not match")
            return
        }
        
        print("Register: \(name), \(email)")
    }
    
    @IBAction func backToLoginTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
=======

    @objc private func dismissKeyboard() { view.endEditing(true) }

    // MARK: - IBActions
    @IBAction func registerTapped(_ sender: UIButton) {
        animateButton(sender)

        let name = (nameTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let email = (emailTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pass  = (passTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let conf  = (confirmTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !name.isEmpty else { shakeRecognize(nameTF, "Please enter your name"); return }
        guard !email.isEmpty else { shakeRecognize(emailTF, "Please enter your email"); return }
        guard pass.count >= 6 else { shakeRecognize(passTF, "Password must be at least 6 characters"); return }
        guard conf == pass else { shakeRecognize(confirmTF, "Passwords do not match"); return }

        sender.isEnabled = false

        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] _, error in
            guard let self else { return }
            sender.isEnabled = true

            if let error = error {
                self.showAlert(title: "Register Failed", message: error.localizedDescription)
                return
            }

            self.showAlert(title: "Done ✅", message: "Account created successfully!") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func backToLoginTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

>>>>>>> origin/dev
    // MARK: - Animations
    private func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
<<<<<<< HEAD
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
    }
    
=======
            UIView.animate(withDuration: 0.1) { button.transform = .identity }
        }
    }

    private func shakeRecognize(_ tf: UITextField, _ msg: String) {
        shakeTextField(tf)
        showAlert(title: "Oops!", message: msg)
    }

>>>>>>> origin/dev
    private func shakeTextField(_ textField: UITextField) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-10, 10, -8, 8, -5, 5, -2, 2, 0]
        textField.layer.add(animation, forKey: "shake")
<<<<<<< HEAD
        
=======

>>>>>>> origin/dev
        textField.layer.borderColor = UIColor.systemRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            textField.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        }
    }
<<<<<<< HEAD
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
=======

    // MARK: - Alert
    private func showAlert(title: String, message: String, onOk: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in onOk?() })
>>>>>>> origin/dev
        present(alert, animated: true)
    }
}
