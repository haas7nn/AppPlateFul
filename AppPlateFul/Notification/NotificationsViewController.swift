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

    private var currentUserId: String = "user_1"
       private var allNotifications: [AppNotification] = []

       private var filteredNotifications: [AppNotification] {
           let selected = segmentedControl.selectedSegmentIndex
           if selected == 0 { return allNotifications }
           if selected == 1 { return allNotifications.filter { !$0.isAnnouncement } }
           return allNotifications.filter { $0.isAnnouncement }
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
           loadNotifications()
       }

       private func loadNotifications() {
           // currentUserId = Auth.auth().currentUser?.uid ?? "user_1"

           NotificationService.shared.fetchNotifications(for: currentUserId) { [weak self] items in
               guard let self = self else { return }
               self.allNotifications = items
               self.tableView.reloadData()
           }
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

                cell.configure(
                    title: item.title,
                    message: item.message,
                    time: timeAgoString(from: item.createdAt),
                    iconName: item.isAnnouncement ? "megaphone.fill" : "bell.fill"
                )

                return cell
            }

            private func timeAgoString(from date: Date) -> String {
                let seconds = Int(Date().timeIntervalSince(date))

                if seconds < 60 { return "\(seconds)s" }
                let minutes = seconds / 60
                if minutes < 60 { return "\(minutes)m" }
                let hours = minutes / 60
                if hours < 24 { return "\(hours)h" }
                let days = hours / 24
                return "\(days)d"
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
