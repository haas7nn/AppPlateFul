//
//  OrganizationDiscoveryViewController.swift
//  AppPlateFul
//
//  Created by Hassan on 28/12/2025.
//

import UIKit

class OrganizationDiscoveryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var searchNGOsButton: UIButton!
    @IBOutlet weak var verifiedButton: UIButton!

    // MARK: - Model
    struct NGO {
        let name: String
        let description: String
        let fullDescription: String
        let verified: Bool
        let imageName: String
        let rating: Double
        let reviews: Int
        let phone: String
        let email: String
        let address: String
    }

    private let allNgos: [NGO] = [
        NGO(
            name: "Helping Hands",
            description: "Hand in hand,\nserving generosity.",
            fullDescription: "Helping Hands is dedicated to providing food, shelter, and support to families in need. We believe in the power of community and work tirelessly to ensure no one goes hungry.",
            verified: true,
            imageName: "HelpingHands",
            rating: 4.5,
            reviews: 423,
            phone: "+973 33001122",
            email: "info@helpinghands.org",
            address: "Manama, Bahrain"
        ),
        NGO(
            name: "Care Bridge",
            description: "Together, We bring\nFood & Hope.",
            fullDescription: "Care Bridge connects donors with communities in need. We focus on sustainable food programs and building bridges between those who want to help and those who need it most.",
            verified: true,
            imageName: "CareBridge",
            rating: 4.3,
            reviews: 312,
            phone: "+973 33112233",
            email: "info@carebridge.org",
            address: "Riffa, Bahrain"
        ),
        NGO(
            name: "Hope Line",
            description: "Bringing hope\ntogether.",
            fullDescription: "Hope Line provides mental health support and crisis intervention services. Our trained volunteers are available 24/7 to help those in emotional distress.",
            verified: false,
            imageName: "HopeLine",
            rating: 4.1,
            reviews: 189,
            phone: "+973 33223344",
            email: "info@hopeline.org",
            address: "Muharraq, Bahrain"
        ),
        NGO(
            name: "Nourish Network",
            description: "Action against\nhunger.",
            fullDescription: "Nourish Network fights hunger through food rescue programs, community kitchens, and nutrition education. We've served over 1 million meals to date.",
            verified: true,
            imageName: "NourishNetwork",
            rating: 4.6,
            reviews: 567,
            phone: "+973 33334455",
            email: "info@nourishnetwork.org",
            address: "Isa Town, Bahrain"
        ),
        NGO(
            name: "Hands on Earth",
            description: "Saving earth with\nour hands.",
            fullDescription: "Hands on Earth is a global environmental organization dedicated to protecting our planet through community action, sustainable practices, and education.",
            verified: false,
            imageName: "HandsOnEarth",
            rating: 4.3,
            reviews: 531,
            phone: "+973 33999999",
            email: "info@handsearth.org",
            address: "Manama, Bahrain"
        ),
        NGO(
            name: "Randal Help",
            description: "Everyone deserves\na good life.",
            fullDescription: "Randal Help is committed to improving the quality of life for underprivileged communities. We provide food, shelter, education, and healthcare support.",
            verified: false,
            imageName: "RandalHelp",
            rating: 4.2,
            reviews: 753,
            phone: "+973 34948656",
            email: "info@randalhelp.org",
            address: "Saar, Bahrain"
        ),
        NGO(
            name: "Rajab Batsmen",
            description: "Empowering lives\none step at a time.",
            fullDescription: "Rajab Batsmen focuses on youth empowerment through sports and education. We believe in building character, discipline, and teamwork skills.",
            verified: false,
            imageName: "RajabBatsmen",
            rating: 4.1,
            reviews: 412,
            phone: "+973 33112233",
            email: "info@rajabbatsmen.org",
            address: "Riffa, Bahrain"
        ),
        NGO(
            name: "Bahrain Hands",
            description: "Hope in action\nchange in motion.",
            fullDescription: "Bahrain Hands is a humanitarian organization providing emergency relief, disaster response, and long-term development programs.",
            verified: false,
            imageName: "BahrainHands",
            rating: 4.4,
            reviews: 620,
            phone: "+973 33445566",
            email: "info@bahrainhands.org",
            address: "Isa Town, Bahrain"
        ),
    ]

    private var filteredNgos: [NGO] = []
    private var isShowingVerifiedOnly = false
    private var isSearchActive = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Organization Discovery"
        
        configureNavigationBar()

        filteredNgos = allNgos

        collectionView.dataSource = self
        collectionView.delegate = self

        searchBar.delegate = self
        searchBar.isHidden = true
        searchBar.showsCancelButton = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        updateButtonStyles()
    }
    
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

    // MARK: - Actions
    @IBAction func searchNGOsTapped(_ sender: UIButton) {
        isSearchActive.toggle()

        UIView.animate(withDuration: 0.3) {
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
                $0.description.lowercased().contains(query)
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
            searchNGOsButton.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1.0)
            searchNGOsButton.setTitleColor(.systemBlue, for: .normal)
        }

        if isShowingVerifiedOnly {
            verifiedButton.backgroundColor = .systemBlue
            verifiedButton.setTitleColor(.white, for: .normal)
        } else {
            verifiedButton.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1.0)
            verifiedButton.setTitleColor(.systemBlue, for: .normal)
        }
    }

    // MARK: - Navigation to Details
    private func openDetails(for ngo: NGO) {
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)
        
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "NGODetailsViewController") as? NGODetailsViewController else {
            print("Could not find NGODetailsViewController")
            return
        }
        
        // Pass data to details screen
        detailsVC.ngoName = ngo.name
        detailsVC.ngoDescription = ngo.fullDescription
        detailsVC.ngoImageName = ngo.imageName
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNgos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NGOCardCell",
                                                      for: indexPath) as! NGOCardCell

        let ngo = filteredNgos[indexPath.item]
        cell.nameLabel.text = ngo.name
        cell.descriptionLabel.text = ngo.description
        cell.verifiedBadgeView.isHidden = !ngo.verified
        
        // Set delegate for Learn More button
        cell.delegate = self

        // Set the logo image
        if let image = UIImage(named: ngo.imageName) {
            cell.logoImageView.image = image
            cell.logoImageView.tintColor = nil
        } else {
            cell.logoImageView.image = UIImage(systemName: "building.2.fill")
            cell.logoImageView.tintColor = .gray
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OrganizationDiscoveryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ngo = filteredNgos[indexPath.item]
        openDetails(for: ngo)
    }
}

// MARK: - NGOCardCellDelegate
extension OrganizationDiscoveryViewController: NGOCardCellDelegate {
    
    func didTapLearnMore(at cell: NGOCardCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let ngo = filteredNgos[indexPath.item]
        openDetails(for: ngo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OrganizationDiscoveryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 16
        let width = (collectionView.bounds.width - spacing) / 2
        return CGSize(width: width, height: 280)
    }
}

// MARK: - UISearchBarDelegate
extension OrganizationDiscoveryViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applyFilters()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearchActive = false

        UIView.animate(withDuration: 0.3) {
            self.searchBar.isHidden = true
            self.filterStackView.isHidden = false
        }

        searchBar.resignFirstResponder()
        applyFilters()
        updateButtonStyles()
    }
}
