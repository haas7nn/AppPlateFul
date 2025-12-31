//
//  NotificationsViewController.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 31/12/2025.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var allNotifications: [(title: String, message: String, time: String, icon: String, type: Int)] = [
        ("Donation Accepted", "An NGO accepted your donation.", "2m", "checkmark.circle.fill", 1),
        ("Pickup Scheduled", "Pickup is scheduled for tomorrow.", "1h", "calendar", 1),
        ("Announcement", "New NGOs joined the platform.", "1d", "megaphone.fill", 2),
        ("Message", "NGO sent you a message.", "3d", "message.fill", 1)
    ]

    private var filteredNotifications: [(title: String, message: String, time: String, icon: String, type: Int)] {
        let selected = segmentedControl.selectedSegmentIndex
        if selected == 0 { return allNotifications }
        return allNotifications.filter { $0.type == selected }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notifications"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        segmentedControl.selectedSegmentIndex = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        let item = filteredNotifications[indexPath.row]

        cell.configure(title: item.title, message: item.message, time: item.time, iconName: item.icon)

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
