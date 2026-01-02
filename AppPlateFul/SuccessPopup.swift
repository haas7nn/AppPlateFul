import UIKit

final class SuccessPopupVC: UIViewController {
    let msg: String
    init(_ msg: String) { self.msg = msg; super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)

        let box = UIView()
        box.backgroundColor = .systemBackground
        box.layer.cornerRadius = 16
        box.translatesAutoresizingMaskIntoConstraints = false

        let img = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        img.tintColor = .systemGreen
        img.translatesAutoresizingMaskIntoConstraints = false

        let lb = UILabel()
        lb.text = msg
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 15, weight: .semibold)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(box); box.addSubview(img); box.addSubview(lb)

        NSLayoutConstraint.activate([
            box.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            box.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            box.widthAnchor.constraint(equalToConstant: 280),

            img.topAnchor.constraint(equalTo: box.topAnchor, constant: 20),
            img.centerXAnchor.constraint(equalTo: box.centerXAnchor),
            img.widthAnchor.constraint(equalToConstant: 40),
            img.heightAnchor.constraint(equalToConstant: 40),

            lb.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 12),
            lb.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 14),
            lb.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -14),
            lb.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -20)
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { self.dismiss(animated: true) }
    }
}

extension UIViewController {
    func popup(_ text: String) { present(SuccessPopupVC(text), animated: true) }
    func alert(_ t: String, _ m: String) {
        let a = UIAlertController(title: t, message: m, preferredStyle: .alert)
        a.addAction(.init(title: "OK", style: .default))
        present(a, animated: true)
    }
}
