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
        let verified: Bool
        let imageName: String
    }

        private let allNgos: [NGO] = [
        NGO(name: "Helping Hands",    description: "Hand in hand,\nserving generosity.",   verified: true,  imageName: "HelpingHands"),
        NGO(name: "Care Bridge",      description: "Together, We bring\nFood & Hope.",      verified: true,  imageName: "CareBridge"),
        NGO(name: "Hope Line",        description: "Bringing hope\ntogether.",             verified: false, imageName: "HopeLine"),
        NGO(name: "Nourish Network",  description: "Action against\nhunger.",               verified: true,  imageName: "NourishNetwork")
    ]

    private var filteredNgos: [NGO] = []
    private var isShowingVerifiedOnly = false
    private var isSearchActive = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Organization Discovery"

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

        let q = (searchBar.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        if !q.isEmpty {
            results = results.filter {
                $0.name.lowercased().contains(q) ||
                $0.description.lowercased().contains(q)
            }
        }

        filteredNgos = results
        collectionView.reloadData()
    }

    // MARK: - Buttons UI
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
}

// MARK: - UICollectionViewDataSource
extension OrganizationDiscoveryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredNgos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NGOCardCell",
                                                      for: indexPath) as! NGOCardCell

        let ngo = filteredNgos[indexPath.item]
        cell.nameLabel.text = ngo.name
        cell.descriptionLabel.text = ngo.description
        cell.verifiedBadgeView.isHidden = !ngo.verified

        // ✅ Set the logo image (from Assets)
        cell.logoImageView.image = UIImage(named: ngo.imageName)

        // Fallback if image name is wrong / missing
        if cell.logoImageView.image == nil {
            cell.logoImageView.image = UIImage(systemName: "building.2.fill")
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OrganizationDiscoveryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let total: CGFloat = 16 // spacing between 2 columns
        let width = (collectionView.bounds.width - total) / 2
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
