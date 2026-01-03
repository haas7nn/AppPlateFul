import UIKit
import FirebaseFirestore

final class TrackingOrderViewController: UIViewController {

    @IBOutlet weak var deliveredView: UIView?
    @IBOutlet weak var statusTitleLabel: UILabel?
    @IBOutlet weak var statusTimeLabel: UILabel?
    @IBOutlet weak var confirmButton: UIButton?

    private let db = Firestore.firestore()
    var orderId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        if let btn = confirmButton {
            btn.isUserInteractionEnabled = true
            btn.isHidden = false
            btn.isEnabled = true
            btn.superview?.bringSubviewToFront(btn)
        }

        guard let id = orderId, !id.isEmpty else { return }
        loadOrder(id: id)
    }

    private func setupUI() {
        deliveredView?.layer.cornerRadius = 22
        deliveredView?.clipsToBounds = false
        deliveredView?.addShadow()

        confirmButton?.layer.cornerRadius = 22
        confirmButton?.clipsToBounds = false
        confirmButton?.addShadow()

        if let gestures = view.gestureRecognizers {
            gestures.forEach {
                $0.cancelsTouchesInView = false
            }
        }
    }

    private func loadOrder(id: String) {
        db.collection("orders").document(id).getDocument { [weak self] snap, _ in
            guard let self else { return }

            let data = snap?.data() ?? [:]
            let status = (data["status"] as? String ?? "").lowercased()

            if status == "delivered" {
                self.showDeliveredUI(date: (data["deliveredAt"] as? Timestamp)?.dateValue())
            } else {
                self.statusTitleLabel?.text = "On the way"
                self.statusTimeLabel?.text = "—"
                self.confirmButton?.isHidden = false
                self.confirmButton?.isEnabled = true
            }
        }
    }

    @IBAction func didTapConfirm(_ sender: UIButton) {
        print("✅ CONFIRM BUTTON TAPPED")

        let alert = UIAlertController(
            title: "Delivery Confirmed ✅",
            message: "Button is working now.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        guard let id = orderId else { return }

        db.collection("orders").document(id).updateData([
            "status": "delivered",
            "deliveredAt": Timestamp(date: Date())
        ])
    }

    private func showDeliveredUI(date: Date?) {
        statusTitleLabel?.text = "Delivered ✅"
        statusTimeLabel?.text = format(date ?? Date())
        confirmButton?.isHidden = true
    }

    private func format(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f.string(from: d)
    }
}

private extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 14
        layer.shadowOffset = CGSize(width: 0, height: 8)
    }
}
