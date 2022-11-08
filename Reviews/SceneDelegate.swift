//
//  SceneDelegate.swift
//  Reviews

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        let viewController = ReviewsVC(nibName: nil, bundle: nil)
        window?.rootViewController = viewController

        window?.makeKeyAndVisible()
    }
}
