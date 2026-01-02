import UIKit

class DonationListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func confirmDonationbutton(_ sender: UIButton) {
        
            let alert = UIAlertController(title: "Success", message: "Donation Confirmed ✅", preferredStyle: .alert)
            present(alert, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true, completion: nil)
    }
    
    }
}
 
