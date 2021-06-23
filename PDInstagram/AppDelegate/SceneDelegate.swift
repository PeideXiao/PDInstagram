//
//  SceneDelegate.swift
//  PDInstagram
//
//  Created by User on 6/21/21.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureInitialRootViewController()
    }

}

extension SceneDelegate {
    
    func configureInitialRootViewController() {
        var vc: UIViewController?
        if let _ = User.current {
            vc = UIStoryboard(type: .main).instantiateInitialViewController()
        } else {
            vc = UIStoryboard(type: .login).instantiateInitialViewController()
        }
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}

