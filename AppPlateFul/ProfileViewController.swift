import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        styleButton(tag: 101) // Settings
        styleButton(tag: 102) // Edit Profile
        styleButton(tag: 103) // Sign Out (optional)
    }

    private func styleButton(tag: Int) {
        guard let b = view.viewWithTag(tag) as? UIButton else { return }

   
        b.layer.cornerRadius = b.bounds.height / 2
        b.layer.masksToBounds = false
        b.clipsToBounds = false

  
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOpacity = 0.18
        b.layer.shadowRadius = 16
        b.layer.shadowOffset = CGSize(width: 0, height: 8)

        b.superview?.clipsToBounds = false
    }
}
