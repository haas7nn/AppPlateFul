//
//  FavoriteNGODetailsViewController.swift
//  AppPlateFul
//
//  202301625 - Samana
//

import UIKit

// Displays full details for a selected favorite NGO
final class FavoriteNGODetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var phoneInfoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    // MARK: - Data
    var ngo: FavoriteNGO!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        configureNavigationBar()
        configureUI()
    }

    // MARK: - Navigation Bar
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =
            UIColor(red: 0.98, green: 0.96, blue: 0.94, alpha: 1.0)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemBlue
    }

    // MARK: - UI
    // Populates the view with NGO details
    private func configureUI() {
        guard let ngo = ngo else {
            fatalError("FavoriteNGO not injected")
        }

        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit

        if let image = UIImage(named: ngo.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")
            imageView.tintColor = .lightGray
            imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }

        nameLabel.text = ngo.name
        ratingLabel.text = "\(ngo.rating) (\(ngo.reviews))"
        descriptionLabel.text = ngo.fullDescription

        phoneInfoLabel.text = "Contact us: \(ngo.phone)"
        emailLabel.text = "Email: \(ngo.email)"
        addressLabel.text = "Address: \(ngo.address)"
    }

    // MARK: - Actions
    // Opens the phone dialer for the NGO number
    @IBAction func phoneTapped(_ sender: UIButton) {
        let cleanNumber = ngo.phone.filter { "0123456789+".contains($0) }

        let alert = UIAlertController(
            title: "Call NGO",
            message: ngo.phone,
            preferredStyle: .actionSheet
        )

        alert.addAction(UIAlertAction(title: "Call", style: .default) { _ in
            if let url = URL(string: "tel://\(cleanNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // Opens the SMS composer for the NGO number
    @IBAction func messageTapped(_ sender: UIButton) {
        let cleanNumber = ngo.phone.filter { "0123456789+".contains($0) }

        let alert = UIAlertController(
            title: "Message",
            message: "Send message to \(ngo.name)",
            preferredStyle: .actionSheet
        )

        alert.addAction(UIAlertAction(title: "Message", style: .default) { _ in
            if let url = URL(string: "sms:\(cleanNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
