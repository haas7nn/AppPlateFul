//
//  NGODetailsViewController.swift
//  AppPlateFul
//
//  Created by Hassan on 28/12/2025.
//

import UIKit

class NGODetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var phoneInfoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var verifiedBadgeView: UIView!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!

    // MARK: - Data (passed from previous screen)
    var ngoName: String = ""
    var ngoDescription: String = ""
    var ngoImageName: String = ""
    var ngoRating: Double = 0.0
    var ngoReviews: Int = 0
    var ngoPhone: String = ""
    var ngoEmail: String = ""
    var ngoAddress: String = ""
    var isVerified: Bool = false

    // MARK: - Favorites State
    private var isFavorite: Bool = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"
        configureNavigationBar()
        configureUI()
        checkIfFavorite()
        updateFavoriteButtonState()
    }

    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.94, alpha: 1.0)
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

    private func configureUI() {
        // Image
        imageView.backgroundColor = .clear
        if let image = UIImage(named: ngoImageName) {
            imageView.image = image
            imageView.tintColor = nil
        } else {
            imageView.image = UIImage(systemName: "photo")
            imageView.tintColor = .lightGray
            imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }

        // Name & Rating
        nameLabel.text = ngoName
        ratingLabel.text = "\(ngoRating) (\(ngoReviews))"

        // Description
        descriptionLabel.text = ngoDescription

        // Contact Info
        phoneInfoLabel.text = "Contact us: \(ngoPhone)"
        emailLabel.text = "Email: \(ngoEmail)"
        addressLabel.text = "Address: \(ngoAddress)"

        // Verified Badge
        verifiedBadgeView.isHidden = !isVerified

        // Style buttons
        styleActionButtons()
    }

    private func styleActionButtons() {
        let buttonGreen = UIColor(red: 0.73, green: 0.80, blue: 0.63, alpha: 1.0)
        
        // Add to Favorites
        addToFavoritesButton.backgroundColor = buttonGreen
        addToFavoritesButton.setTitleColor(.white, for: .normal)
        addToFavoritesButton.layer.cornerRadius = 12
        addToFavoritesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addToFavoritesButton.clipsToBounds = true
        
        // Reviews
        reviewsButton.backgroundColor = buttonGreen
        reviewsButton.setTitleColor(.white, for: .normal)
        reviewsButton.layer.cornerRadius = 12
        reviewsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        reviewsButton.clipsToBounds = true
    }


    // MARK: - Favorites Logic
    private func checkIfFavorite() {
        let favorites = UserDefaults.standard.stringArray(forKey: "favoriteNGOs") ?? []
        isFavorite = favorites.contains(ngoName)
    }

    private func updateFavoriteButtonState() {
        let buttonGreen = UIColor(red: 0.73, green: 0.80, blue: 0.63, alpha: 1.0)

        if isFavorite {
            addToFavoritesButton.setTitle("Remove from Favorites", for: .normal)
            addToFavoritesButton.backgroundColor = buttonGreen
            addToFavoritesButton.setTitleColor(.systemRed, for: .normal) // 🔴 red text
        } else {
            addToFavoritesButton.setTitle("Add to Favorites", for: .normal)
            addToFavoritesButton.backgroundColor = buttonGreen
            addToFavoritesButton.setTitleColor(.white, for: .normal)
        }
    }



    private func saveFavorite() {
        var favorites = UserDefaults.standard.stringArray(forKey: "favoriteNGOs") ?? []
        if !favorites.contains(ngoName) {
            favorites.append(ngoName)
            UserDefaults.standard.set(favorites, forKey: "favoriteNGOs")
        }
    }

    private func removeFavorite() {
        var favorites = UserDefaults.standard.stringArray(forKey: "favoriteNGOs") ?? []
        favorites.removeAll { $0 == ngoName }
        UserDefaults.standard.set(favorites, forKey: "favoriteNGOs")
    }

    // MARK: - Actions
    @IBAction func phoneTapped(_ sender: UIButton) {
        let cleanNumber = ngoPhone.filter { "0123456789+".contains($0) }

        let alert = UIAlertController(title: "Call NGO", message: ngoPhone, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Call", style: .default) { _ in
            if let url = URL(string: "tel://\(cleanNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @IBAction func messageTapped(_ sender: UIButton) {
        let cleanNumber = ngoPhone.filter { "0123456789+".contains($0) }

        let alert = UIAlertController(title: "Message", message: "Send message to \(ngoName)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Message", style: .default) { _ in
            if let url = URL(string: "sms:\(cleanNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @IBAction func addToFavoritesTapped(_ sender: UIButton) {

        // If already favorite → confirm removal
        if isFavorite {
            let alert = UIAlertController(
                title: "Remove from Favorites?",
                message: "\(ngoName) will be removed from your favorites.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
                self.isFavorite = false
                self.removeFavorite()
                self.updateFavoriteButtonState()

                self.showAlert(
                    title: "Removed from Favorites",
                    message: "\(self.ngoName) has been removed from your favorites."
                )
            })

            present(alert, animated: true)
            return
        }

        // Not favorite → add immediately
        isFavorite = true
        saveFavorite()
        updateFavoriteButtonState()

        showAlert(
            title: "Added to Favorites!",
            message: "\(ngoName) has been added to your favorites."
        )
    }


    @IBAction func reviewsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)

        if let reviewsVC = storyboard.instantiateViewController(withIdentifier: "NGOReviewsViewController") as? NGOReviewsViewController {
            reviewsVC.ngoName = ngoName
            reviewsVC.ngoImageName = ngoImageName
            reviewsVC.ngoRating = ngoRating
            reviewsVC.ngoReviews = ngoReviews
            reviewsVC.isVerified = isVerified
            reviewsVC.ngoAddress = ngoAddress

            navigationController?.pushViewController(reviewsVC, animated: true)
        } else {
            showAlert(title: "Error", message: "NGOReviewsViewController not found. Check Storyboard ID.")
        }
    }

    

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
