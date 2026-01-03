//
//  ViewController.swift
//  Donor Home
//
//  Created by Jxu on 21/12/2025.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var submitButton: UIButton! // Connect this from storyboard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        
        // Make the label show the starting number
        textLabel.text = "\(Int(stepper.value))"
        
        // Disable submit button initially
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
    }

    @IBAction func stepperClicked(_ sender: UIStepper) {
        let currentNumber = Int(sender.value)
        textLabel.text = "\(currentNumber)"
        
        // Enable or disable submit button based on stepper value
        if currentNumber > 0 {
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        } else {
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
    }
    
    @IBAction func submitDonationTapped(_ sender: UIButton) {
        let quantity = Int(stepper.value)
        guard quantity > 0 else { return } // Safety check
        
        let alert = UIAlertController(
            title: "Donation Submitted",
            message: "Your donation of \(quantity) item(s) will be saved as Pending ✅",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        // Reset stepper and disable button
        stepper.value = 0
        textLabel.text = "0"
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
    }
}
