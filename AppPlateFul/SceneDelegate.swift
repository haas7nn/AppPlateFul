import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        // 🔥 RUN ONCE ONLY — DELETE AFTER SEEDING
        UserSeeder.seedUsers()

        let window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(name: "DonorDashboard", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()

        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
