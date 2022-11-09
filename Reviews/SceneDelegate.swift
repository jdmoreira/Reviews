import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    let serviceProvider: ServiceProvider = HTTPServiceProvider()
    // or MockedServiceProvider() for simulating errors, delays, etc..

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        // Simple VC with a spinner that we can use
        // while waiting for the server response
        let spinnerVC = UIViewController()
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinnerVC.view.embed(spinner)

        // Setup the window
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        window?.rootViewController = spinnerVC
        window?.makeKeyAndVisible()

        serviceProvider.loadBusiness(with: .philsBurger) { [unowned self] result in
            let vc = window?.rootViewController

            switch result {
            case .failure(let error):
                vc?.presentError(title: "Error occurred",
                                 message: "Unexpected error: \(error)")
            case .success(let business):
                guard let business = business else {
                    vc?.presentError(title: "Error occurred",
                                     message: "No business was found with for this id.")
                    return
                }
                window?.rootViewController = ReviewsVC(with: business)
            }
        }
    }
}

private extension UIViewController {
    func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
