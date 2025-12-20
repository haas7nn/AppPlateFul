import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // Load AdminDashboard storyboard
        let storyboard = UIStoryboard(name: "AdminDashboard", bundle: nil)

        // Get initial view controller
        let rootVC = storyboard.instantiateInitialViewController()!

        // Set root view controller
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called when the scene is released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart tasks paused when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Sent when the scene will move from active to inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from background to foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data if needed.
    }
}
