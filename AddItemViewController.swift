import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!


    @IBAction func stepperChanged(_ sender: UIStepper) {
        counterLabel.text = "\(Int(sender.value))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "0"
    }
}
