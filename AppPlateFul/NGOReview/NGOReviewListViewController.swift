//
//  NGOReviewListViewController.swift
//  AppPlateFul
//

import UIKit
import FirebaseFirestore

class NGOReviewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!

    private var ngoList: [NGOReviewItem] = []
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NGO Review"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(closeTapped)
        )

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70

        loadData()
    }

    deinit {
        listener?.remove()
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    // MARK: - Firestore load
    private func loadData() {
        listener?.remove()

        listener = db.collection("ngo_reviews")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snap, err in
                guard let self = self else { return }

                if let err = err {
                    print("Firestore error:", err.localizedDescription)
                    self.useFallback()
                    return
                }

                let items = snap?.documents.compactMap {
                    NGOReviewItem(doc: $0)
                } ?? []

                self.ngoList = items.isEmpty ? NGOReviewItem.sampleData : items
                self.tableView.reloadData()
                self.emptyStateLabel.isHidden = !self.ngoList.isEmpty
            }
    }

    private func useFallback() {
        ngoList = NGOReviewItem.sampleData
        tableView.reloadData()
        emptyStateLabel.isHidden = !ngoList.isEmpty
    }

    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ngoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NGOCell", for: indexPath)
        let ngo = ngoList[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = ngo.name
        content.secondaryText = ngo.status
        content.secondaryTextProperties.color = .systemOrange
        content.image = ngo.logoImage
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        content.imageProperties.cornerRadius = 10

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openDetail(for: ngoList[indexPath.row])
    }

    // MARK: - Navigation
    private func openDetail(for ngo: NGOReviewItem) {
        let storyboard = UIStoryboard(name: "NGOReview", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "NGOReviewDetailViewController"
        ) as! NGOReviewDetailViewController

        vc.ngo = ngo
        vc.onDecision = { [weak self] id in
            self?.ngoList.removeAll { $0.id == id }
            self?.tableView.reloadData()
            self?.emptyStateLabel.isHidden = !(self?.ngoList.isEmpty ?? true)
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}
