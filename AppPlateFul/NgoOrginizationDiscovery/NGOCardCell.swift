import UIKit

protocol NGOCardCellDelegate: AnyObject {
    func didTapLearnMore(at cell: NGOCardCell)
}

final class NGOCardCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var verifiedBadgeView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var learnMoreButton: UIButton!

    weak var delegate: NGOCardCellDelegate?

    private var imageTask: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        learnMoreButton.addTarget(self, action: #selector(learnMoreTapped), for: .touchUpInside)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil

        logoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        verifiedBadgeView.isHidden = true
    }

    @objc private func learnMoreTapped() {
        delegate?.didTapLearnMore(at: self)
    }

    func configure(with ngo: NGO) {
        nameLabel.text = ngo.name
        descriptionLabel.text = ngo.desc
        verifiedBadgeView.isHidden = !ngo.verified

        logoImageView.image = UIImage(systemName: "photo")

        imageTask?.cancel()
        imageTask = nil

        guard let url = URL(string: ngo.logoURL), !ngo.logoURL.isEmpty else { return }

        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.logoImageView.image = img
            }
        }
        imageTask?.resume()
    }
}
