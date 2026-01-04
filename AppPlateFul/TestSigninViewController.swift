//
//  TestSigninViewController.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 04/01/2026.
//

import UIKit

class TestSigninViewController: UIViewController {

    @IBOutlet weak var Donorbtn: UIButton!
    @IBOutlet weak var Collectorbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func ngobtn(_ sender: Any) {
        UserSession.shared.login(
               userId: "ngo_1",
               role: .ngo
           )

           let storyboard = UIStoryboard(name: "NgoFlow", bundle: nil)
           let ngoTabBar = storyboard.instantiateViewController(
               withIdentifier: "ngoFlow"
           )

           guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                 let window = windowScene.windows.first else {
               return
           }

           window.rootViewController = ngoTabBar
           window.makeKeyAndVisible()
    }
    
    @IBAction func donorbtn(_ sender: Any) {
        UserSession.shared.login(
            userId: "donor_1",
            role: .donor
        )

        let storyboard = UIStoryboard(name: "DonorDashboard", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(
            withIdentifier: "MainTabBarController"
        )

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
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
