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
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.value = 0
                stepper.minimumValue = 0
                stepper.maximumValue = 100
                
                // Make the label show the starting number
                textLabel.text = "\(Int(stepper.value))"
    }


    @IBAction func stepperClicked(_ sender: UIStepper) {
        let currentNumber = Int(sender.value)
                
                // Update the label text
                textLabel.text = "\(currentNumber)"
    }
    
    
    
    
   
   
   
    }
   

        
            
        
    


