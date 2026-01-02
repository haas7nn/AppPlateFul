import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {

    // مربوطة من الستوري بورد
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // إعدادات بسيطة
        passTF.isSecureTextEntry = true
        emailTF.autocapitalizationType = .none

        // إخفاء الكيبورد عند اللمس
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    // زر Login
    @IBAction func loginTapped(_ sender: UIButton) {
        hideKeyboard()

        let email = emailTF.text ?? ""
        let pass  = passTF.text ?? ""

        // تحقق بسيط
        if email.isEmpty || pass.isEmpty {
            showAlert("Error", "Please enter email and password")
            return
        }

        // تسجيل دخول Firebase
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert("Login Failed", error.localizedDescription)
            } else {
                // نجاح
                self.showAlert("Success", "Welcome Back ✅")
            }
        }
    }

    // Alert بسيط
    func showAlert(_ title: String, _ msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

