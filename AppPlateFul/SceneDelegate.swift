import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        

        let window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(name: "TestSignin", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()

        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
