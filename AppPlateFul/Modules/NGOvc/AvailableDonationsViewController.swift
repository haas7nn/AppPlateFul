//
//  AvailableDonationsViewController.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 25/12/2025.
//

import UIKit

class AvailableDonationsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    
    struct Donation {
        let name: String
        let donator: String       
        let description: String
        let quantity: String
        let expiryDate: String
        let image: UIImage?
    }


    
    let data: [Donation] = [
        .init(
            name: "Blood Donation",
            donator: "Chocologi Cafe",
            description: "Fundue plate comes with churros, mini pancakes and nutella chocolate sauce.",
            quantity: "10 plates",
            expiryDate: "26-11-2025",
            image: UIImage(systemName: "drop.circle.fill")
        ),
        .init(
            name: "Organ Donation",
            donator: "Hope Medical Center",
            description: "We are looking for volunteers to donate organs.",
            quantity: "2 donors needed",
            expiryDate: "30-11-2025",
            image: UIImage(systemName: "person.circle.fill")
        )
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "Available Donations"
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "donation", for: indexPath) as! AvailableDonationCell
        cell.TitleLabel.text = data[indexPath.row].name
        cell.button.setTitle("Donate Now", for: .normal)
        cell.iconImageView.image = data[indexPath.row].image
        cell.subtitleLabel.text = data[indexPath.row].description
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(donateNowTapped(_:)), for: .touchUpInside)
        
        return cell
        
        

    }
    
    @objc private func donateNowTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showDonationDetails", sender: sender)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDonationDetails" {
            guard let detailsVC = segue.destination as? AcceptAvailableDonationDetailsViewController else { return }
            guard let button = sender as? UIButton else { return }

            let donation = data[button.tag]

            detailsVC.donatorText = donation.donator
            detailsVC.descriptionText = donation.description
            detailsVC.quantityText = donation.quantity
            detailsVC.expiryText = donation.expiryDate
            detailsVC.iconImage = donation.image
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
