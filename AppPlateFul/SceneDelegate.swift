import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }


        let window = UIWindow(windowScene: windowScene)

        // Start on Admin Dashboard
        let storyboard = UIStoryboard(name: "AdminDashboard", bundle: nil)

        guard let initialVC = storyboard.instantiateInitialViewController() else {
            assertionFailure("Initial View Controller is not set in AdminDashboard.storyboard")
            return
        }

        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
