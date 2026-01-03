import UIKit

final class FavoriteNGOsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var collectionView: UICollectionView!

    private let ngos: [FavoriteNGO] = [
        FavoriteNGO(
            name: "Hands on earth",
            desc: "Saving earth with our hands.",
            fullDescription: "Hands on Earth is a dedicated non-profit organization committed to protecting our planet and empowering communities through sustainable action.",
            imageName: "HandsOnEarth",
            rating: 4.3,
            reviews: 531,
            phone: "+973 33999999",
            email: "info@handsearth.org",
            address: "Manama, Bahrain"
        ),
        FavoriteNGO(
            name: "Randal Help",
            desc: "Everyone deserves a good life.",
            fullDescription: "Randal Help NGO is a community-driven, non-profit organization dedicated to improving the lives of vulnerable individuals and underserved communities.",
            imageName: "RandalHelp",
            rating: 4.2,
            reviews: 753,
            phone: "+973 34948656",
            email: "info@randalhelp.org",
            address: "Saar, Bahrain"
        ),
        FavoriteNGO(
            name: "Rajab batsmen",
            desc: "Empowering lives one step at a time.",
            fullDescription: "Rajab batsmen is an environmental and humanitarian organization dedicated to restoring balance between people and the planet.",
            imageName: "RajabBatsmen",
            rating: 4.1,
            reviews: 412,
            phone: "+973 33112233",
            email: "info@rajabbatsmen.org",
            address: "Riffa, Bahrain"
        ),
        FavoriteNGO(
            name: "Bahrain Hands",
            desc: "Hope in action change in motion.",
            fullDescription: "Bahrain Hands is a grassroots organization committed to nurturing the planet through collective action and community empowerment.",
            imageName: "BahrainHands",
            rating: 4.4,
            reviews: 620,
            phone: "+973 33445566",
            email: "info@bahrainhands.org",
            address: "Isa Town, Bahrain"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite NGOs"

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ngos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FavoriteNGOCell",
            for: indexPath
        ) as? FavoriteNGOCell else {
            fatalError("Cell not found")
        }

        let ngo = ngos[indexPath.item]
        cell.nameLabel.text = ngo.name
        cell.descriptionLabel.text = ngo.desc  // Short description for card

        cell.logoImageView.image = UIImage(named: ngo.imageName)
        if cell.logoImageView.image == nil {
            cell.logoImageView.image = UIImage(systemName: "photo")
            cell.logoImageView.tintColor = .lightGray
        }

        cell.onLearnMoreTapped = { [weak self] in
            self?.openDetails(for: ngo)
        }

        return cell
    }

    private func openDetails(for ngo: FavoriteNGO) {
        let sb = UIStoryboard(name: "FavoriteNGOs", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FavoriteNGODetailsViewController") as? FavoriteNGODetailsViewController else {
            fatalError("Details VC not found")
        }
        vc.ngo = ngo
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = 16
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 16 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 16 }
}
