import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // Launch NGO Organization Discovery first
        let storyboard = UIStoryboard(name: "NgoOrginzationDiscovery", bundle: nil)

        guard let initialVC = storyboard.instantiateInitialViewController() else {
            assertionFailure("Initial View Controller is not set in NgoOrginzationDiscovery.storyboard")
            return
        }

        // Embed in navigation controller if needed
        if let nav = initialVC as? UINavigationController {
            window.rootViewController = nav
        } else {
            window.rootViewController = UINavigationController(rootViewController: initialVC)
        }

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
