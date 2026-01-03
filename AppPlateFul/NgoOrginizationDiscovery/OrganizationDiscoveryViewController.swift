//
//  OrganizationDiscoveryViewController.swift
//  AppPlateFul
//
//  202301625 - Samana
//

import UIKit
import FirebaseFirestore

// Displays a list of approved NGOs with search and filter functionality
class OrganizationDiscoveryViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var searchNGOsButton: UIButton!
    @IBOutlet weak var verifiedButton: UIButton!

    // MARK: - Firebase
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    // MARK: - Data
    private var allNgos: [DiscoveryNGO] = []
    private var filteredNgos: [DiscoveryNGO] = []
    private var isShowingVerifiedOnly = false
    private var isSearchActive = false

    // MARK: - Image Cache
    private let imageCache = NSCache<NSString, UIImage>()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Organization Discovery"
        configureNavigationBar()

        collectionView.dataSource = self
        collectionView.delegate = self

        searchBar.delegate = self
        searchBar.isHidden = true
        searchBar.showsCancelButton = true

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        updateButtonStyles()
        listenApprovedNGOs()
    }

    deinit {
        listener?.remove()
    }

    // MARK: - Navigation Bar
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
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

    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    // MARK: - Firestore
    // Listens for approved NGOs in real time
    private func listenApprovedNGOs() {
        listener?.remove()

        listener = db.collection("ngo_reviews")
            .whereField("approved", isEqualTo: true)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Firestore NGOs error:", error.localizedDescription)
                    return
                }

                let docs = snapshot?.documents ?? []
                self?.allNgos = docs.compactMap { DiscoveryNGO(doc: $0) }
                self?.applyFilters()
            }
    }

    // MARK: - Actions
    @IBAction func searchNGOsTapped(_ sender: UIButton) {
        isSearchActive.toggle()

        UIView.animate(withDuration: 0.25) {
            self.searchBar.isHidden = !self.isSearchActive
            self.filterStackView.isHidden = self.isSearchActive
        }

        if isSearchActive {
            searchBar.becomeFirstResponder()
        } else {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            applyFilters()
        }

        updateButtonStyles()
    }

    @IBAction func verifiedTapped(_ sender: UIButton) {
        isShowingVerifiedOnly.toggle()
        applyFilters()
        updateButtonStyles()
    }

    // MARK: - Filtering
    private func applyFilters() {
        var results = allNgos

        if isShowingVerifiedOnly {
            results = results.filter { $0.verified }
        }

        let query = (searchBar.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        if !query.isEmpty {
            results = results.filter {
                $0.name.lowercased().contains(query) ||
                $0.desc.lowercased().contains(query)
            }
        }

        filteredNgos = results
        collectionView.reloadData()
    }

    // MARK: - Button Styles
    private func updateButtonStyles() {
        if isSearchActive {
            searchNGOsButton.backgroundColor = .systemBlue
            searchNGOsButton.setTitleColor(.white, for: .normal)
        } else {
            searchNGOsButton.backgroundColor =
                UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1.0)
            searchNGOsButton.setTitleColor(.systemBlue, for: .normal)
        }

        if isShowingVerifiedOnly {
            verifiedButton.backgroundColor = .systemBlue
            verifiedButton.setTitleColor(.white, for: .normal)
        } else {
            verifiedButton.backgroundColor =
                UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1.0)
            verifiedButton.setTitleColor(.systemBlue, for: .normal)
        }
    }

    // MARK: - Image Loading
    private func loadImage(
        urlString: String,
        into imageView: UIImageView,
        at indexPath: IndexPath
    ) {
        let key = NSString(string: urlString)

        if let cached = imageCache.object(forKey: key) {
            imageView.image = cached
            imageView.tintColor = nil
            return
        }

        guard let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "building.2.fill")
            imageView.tintColor = .gray
            return
        }

        imageView.image = UIImage(systemName: "building.2.fill")
        imageView.tintColor = .gray

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  let img = UIImage(data: data) else { return }

            self.imageCache.setObject(img, forKey: key)

            DispatchQueue.main.async {
                if let cell =
                    self.collectionView.cellForItem(at: indexPath)
                        as? NGOCardCell {
                    cell.logoImageView.image = img
                    cell.logoImageView.tintColor = nil
                }
            }
        }.resume()
    }

    // MARK: - Navigation
    private func openDetails(for ngo: DiscoveryNGO) {
        let storyboard =
            UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)

        guard let detailsVC =
            storyboard.instantiateViewController(
                withIdentifier: "NGODetailsViewController"
            ) as? NGODetailsViewController else {
            print("Could not find NGODetailsViewController")
            return
        }

        detailsVC.ngoId = ngo.id
        detailsVC.ngoName = ngo.name
        detailsVC.ngoDescription = ngo.fullDescription
        detailsVC.ngoImageName = ngo.imageURL
        detailsVC.ngoRating = ngo.rating
        detailsVC.ngoReviews = ngo.reviews
        detailsVC.ngoPhone = ngo.phone
        detailsVC.ngoEmail = ngo.email
        detailsVC.ngoAddress = ngo.address
        detailsVC.isVerified = ngo.verified

        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension OrganizationDiscoveryViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        filteredNgos.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "NGOCardCell",
                for: indexPath
            ) as! NGOCardCell

        let ngo = filteredNgos[indexPath.item]
        cell.nameLabel.text = ngo.name
        cell.descriptionLabel.text = ngo.desc
        cell.verifiedBadgeView.isHidden = !ngo.verified
        cell.delegate = self

        if !ngo.imageURL.isEmpty {
            loadImage(
                urlString: ngo.imageURL,
                into: cell.logoImageView,
                at: indexPath
            )
        } else {
            cell.logoImageView.image =
                UIImage(systemName: "building.2.fill")
            cell.logoImageView.tintColor = .gray
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OrganizationDiscoveryViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let ngo = filteredNgos[indexPath.item]
        openDetails(for: ngo)
    }
}

// MARK: - NGOCardCellDelegate
extension OrganizationDiscoveryViewController: NGOCardCellDelegate {

    func didTapLearnMore(at cell: NGOCardCell) {
        guard let indexPath =
            collectionView.indexPath(for: cell) else { return }
        let ngo = filteredNgos[indexPath.item]
        openDetails(for: ngo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OrganizationDiscoveryViewController:
    UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let spacing: CGFloat = 16
        let width =
            (collectionView.bounds.width - spacing) / 2
        return CGSize(width: width, height: 280)
    }
}

// MARK: - UISearchBarDelegate
extension OrganizationDiscoveryViewController: UISearchBarDelegate {

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        applyFilters()
    }

    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchBar.text = ""
        isSearchActive = false

        UIView.animate(withDuration: 0.25) {
            self.searchBar.isHidden = true
            self.filterStackView.isHidden = false
        }

        searchBar.resignFirstResponder()
        applyFilters()
        updateButtonStyles()
    }
}
