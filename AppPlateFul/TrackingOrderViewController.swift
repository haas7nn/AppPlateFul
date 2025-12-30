import UIKit

final class TrackingOrderViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tracking order"
    }

    // Connect this to the button (Touch Up Inside)
    @IBAction func didTapConfirm(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Delivery Confirmed",
            message: "Your delivery has been confirmed successfully.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
