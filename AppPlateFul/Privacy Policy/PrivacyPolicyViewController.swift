//
//  PrivacyPolicyViewController.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 01/01/2026.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.957, blue: 0.937, alpha: 1)
        
        // Hide default navigation title (title is in content)
        navigationItem.title = ""
    }
    
    // MARK: - Actions
    @IBAction func backTapped(_ sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
