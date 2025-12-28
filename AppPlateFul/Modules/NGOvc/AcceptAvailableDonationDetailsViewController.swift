//
//  AcceptAvailableDonationDetailsViewController.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 25/12/2025.
//

import UIKit

class AcceptAvailableDonationDetailsViewController: UIViewController {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var donationDesc: UILabel!
    @IBOutlet weak var acceptDonationbtn: UIButton!
    @IBOutlet weak var donator: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var exp: UILabel!
    
    
      var iconImage: UIImage?
      var donatorText: String?
      var descriptionText: String?
      var quantityText: String?
      var expiryText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Donation Details"
            icon.image = iconImage
            donator.text = donatorText
            donationDesc.text = descriptionText
            qty.text = quantityText
            exp.text = expiryText
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func acceptDonationTapped(_ sender: Any) {
        

            // 1️⃣ Business logic placeholder (you’ll expand this later)
            print("Donation accepted logic goes here")

            // 2️⃣ Create alert (no title yet)
            let alert = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .alert
            )

            // 3️⃣ Green check icon
            let image = UIImage(systemName: "checkmark.circle.fill")?
                .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)

            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit

            alert.view.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 30),
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])

            // 4️⃣ Centered title text with proper spacing
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributedTitle = NSAttributedString(
                string: "\n\n\nDonation Accepted",
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
                ]
            )

            alert.setValue(attributedTitle, forKey: "attributedTitle")

            // 5️⃣ OK action
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }

            alert.addAction(okAction)

            // 6️⃣ Present alert
            present(alert, animated: true)
        

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
