import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegisterViewController: UIViewController {

    // اربطهم من الستوري بورد
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!

    private let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // إعدادات بسيطة
        emailTF.autocapitalizationType = .none
        passTF.isSecureTextEntry = true
        confirmTF.isSecureTextEntry = true

        // إخفاء الكيبورد إذا ضغطت على الشاشة
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    // زر Register
    @IBAction func registerTapped(_ sender: UIButton) {
        hideKeyboard()

        let name = (nameTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let email = (emailTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passTF.text ?? ""
        let confirm = confirmTF.text ?? ""

        // تحقق بسيط
        if name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty {
            showAlert("Missing", "Please fill all fields")
            return
        }

        if pass != confirm {
            showAlert("Password", "Passwords not matching")
            return
        }

        // إنشاء حساب Firebase Auth
        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] res, err in
            guard let self = self else { return }

            if let err = err {
                self.showAlert("Register Failed", err.localizedDescription)
                return
            }

            // حفظ بيانات بسيطة في Firestore (اختياري)
            if let uid = res?.user.uid {
                self.db.collection("users").document(uid).setData([
                    "fullName": name,
                    "email": email,
                    "createdAt": FieldValue.serverTimestamp()
                ], merge: true)
            }

            self.showAlert("Success ✅", "Account created")

            // يرجع لصفحة اللوقن
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    // زر "Login" في صفحة التسجيل (اذا عندك زر)
    @IBAction func backToLoginTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    // Alert بسيط
    func showAlert(_ title: String, _ msg: String) {
        let a = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
}
