//
//  NGOReviewsViewController.swift
//  AppPlateFul
//
//  Created by Hassan on 28/12/2025.
//

import UIKit

class NGOReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddReviewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var insightsButton: UIButton!
    
    // MARK: - Data
    var ngoName: String = ""
    var ngoImageName: String = ""
    var ngoRating: Double = 0.0
    var ngoReviews: Int = 0
    var isVerified: Bool = false
    var ngoAddress: String = ""
    
    // Reviews data
    private var reviews: [(name: String, rating: Int, comment: String, date: String)] = []
    
    // Default reviews
    private let defaultReviews: [(name: String, rating: Int, comment: String, date: String)] = [
        ("Ahmed Ali", 5, "Amazing organization! They really helped our community with food distribution.", "Dec 15, 2024"),
        ("Sara Khan", 4, "Great work, very professional and caring staff. Highly recommend!", "Dec 10, 2024"),
        ("Mohammed Hassan", 5, "Highly recommend! They delivered food on time and were very organized.", "Dec 5, 2024"),
        ("Fatima Noor", 4, "Good experience, would donate again. The team is very responsive.", "Nov 28, 2024"),
        ("Khalid Ibrahim", 5, "Excellent service and transparency. You can trust them with your donations.", "Nov 20, 2024"),
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reviews"
        
        loadReviews()
        setupUI()
        setupTableView()
        setupButtons()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.969, green: 0.949, blue: 0.929, alpha: 1.0)
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
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.949, blue: 0.929, alpha: 1.0)
        updateRatingDisplay()
    }
    
    private func updateRatingDisplay() {
        if reviews.isEmpty {
            averageRatingLabel?.text = "⭐️ \(ngoRating)"
            totalReviewsLabel?.text = "Based on \(ngoReviews) reviews"
        } else {
            let totalRating = reviews.reduce(0) { $0 + $1.rating }
            let avgRating = Double(totalRating) / Double(reviews.count)
            averageRatingLabel?.text = "⭐️ \(String(format: "%.1f", avgRating))"
            totalReviewsLabel?.text = "Based on \(reviews.count) reviews"
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReviewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupButtons() {
        addReviewButton?.layer.cornerRadius = 12
        addReviewButton?.clipsToBounds = true
        
        insightsButton?.layer.cornerRadius = 12
        insightsButton?.clipsToBounds = true
    }
    
    // MARK: - Load & Save
    private func loadReviews() {
        let key = "reviews_\(ngoName)"
        if let savedReviews = UserDefaults.standard.array(forKey: key) as? [[String: Any]] {
            reviews = savedReviews.map { dict in
                (
                    name: dict["name"] as? String ?? "",
                    rating: dict["rating"] as? Int ?? 5,
                    comment: dict["comment"] as? String ?? "",
                    date: dict["date"] as? String ?? ""
                )
            }
        } else {
            reviews = defaultReviews
        }
    }
    
    private func saveReviews() {
        let key = "reviews_\(ngoName)"
        let reviewsArray = reviews.map { review -> [String: Any] in
            return [
                "name": review.name,
                "rating": review.rating,
                "comment": review.comment,
                "date": review.date
            ]
        }
        UserDefaults.standard.set(reviewsArray, forKey: key)
    }
    
    // MARK: - Actions
    @IBAction func addReviewTapped(_ sender: Any) {
        let addReviewVC = AddReviewViewController()
        addReviewVC.ngoName = ngoName
        addReviewVC.delegate = self
        addReviewVC.modalPresentationStyle = .overFullScreen
        addReviewVC.modalTransitionStyle = .crossDissolve
        present(addReviewVC, animated: true)
    }
    
    @IBAction func insightsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)
        
        if let insightsVC = storyboard.instantiateViewController(withIdentifier: "NGOInsightsViewController") as? NGOInsightsViewController {
            insightsVC.ngoName = ngoName
            insightsVC.ngoImageName = ngoImageName
            insightsVC.ngoRating = ngoRating
            insightsVC.ngoReviews = ngoReviews
            insightsVC.isVerified = isVerified
            insightsVC.ngoAddress = ngoAddress
            navigationController?.pushViewController(insightsVC, animated: true)
        }
    }
    
    // MARK: - AddReviewDelegate
    func didAddReview(name: String, rating: Int, comment: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        let newReview = (name: name, rating: rating, comment: comment, date: dateString)
        reviews.insert(newReview, at: 0)
        
        saveReviews()
        updateRatingDisplay()
        tableView.reloadData()
        
        let alert = UIAlertController(title: "Thank You! 🎉", message: "Your review has been submitted successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
        let review = reviews[indexPath.row]
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        cell.contentView.addSubview(containerView)
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = review.name
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        containerView.addSubview(nameLabel)
        
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = String(repeating: "⭐️", count: review.rating)
        ratingLabel.font = .systemFont(ofSize: 12)
        containerView.addSubview(ratingLabel)
        
        let commentLabel = UILabel()
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = review.comment
        commentLabel.font = .systemFont(ofSize: 14)
        commentLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        commentLabel.numberOfLines = 0
        containerView.addSubview(commentLabel)
        
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = review.date
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        containerView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            reviews.remove(at: indexPath.row)
            saveReviews()
            updateRatingDisplay()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
