//
//  ReportsAnalyticsViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 01/01/2026.
//

import UIKit

class ReportsAnalyticsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reports & Analytics"
    }
    
    @IBAction func viewDetailedReportsTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowBreakdown", sender: nil)
    }
}
