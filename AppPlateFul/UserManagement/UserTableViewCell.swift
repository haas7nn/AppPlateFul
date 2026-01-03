import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var starButton: UIButton?
    @IBOutlet weak var infoButton: UIButton?

    weak var delegate: UserCellDelegate?
    var indexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        starButton?.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        infoButton?.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }

    private func setupUI() {
        avatarImageView?.layer.cornerRadius = 25
        avatarImageView?.clipsToBounds = true
    }

    func configure(with user: User) {
        configure(
            name: user.name,
            status: user.status,
            isStarred: user.isFavorite
        )
    }

    func configure(name: String, status: String, isStarred: Bool = false) {
        nameLabel?.text = name

        let cleanStatus = status.trimmingCharacters(in: .whitespacesAndNewlines)
        statusLabel?.text = cleanStatus.isEmpty ? "-" : cleanStatus

        switch cleanStatus.lowercased() {
        case "active":
            statusLabel?.textColor = .systemGreen
        case "inactive":
            statusLabel?.textColor = .systemRed
        case "pending":
            statusLabel?.textColor = .systemOrange
        default:
            statusLabel?.textColor = .secondaryLabel
        }

        let starImage = isStarred ? "star.fill" : "star"
        starButton?.setImage(UIImage(systemName: starImage), for: .normal)
        starButton?.tintColor = isStarred ? .systemYellow : .systemGray

        avatarImageView?.image = UIImage(systemName: "person.circle.fill")
        avatarImageView?.tintColor = .systemGray2
    }

    @objc private func starButtonTapped() {
        delegate?.didTapStarButton(at: indexPath)
    }

    @objc private func infoButtonTapped() {
        delegate?.didTapInfoButton(at: indexPath)
    }
}
