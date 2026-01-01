import UIKit

class DeliveryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func confirmDeliveryButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Success", message: "Delivery Confirmed ✅", preferredStyle: .alert)
        present(alert, animated: true)

        // Automatically dismiss alert after 1.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true, completion: nil)
            
            // Navigate to another view if you have a segue
            // Make sure you have created a segue from this VC and identifier matches
            // Uncomment this line if the segue exists
            // self.performSegue(withIdentifier: "YourSegueIdentifier", sender: nil)
        }
    }
}
