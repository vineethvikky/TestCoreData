//
//  SceneDelegate.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        setListViewController(scene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    func setListViewController(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        let listViewController = ListViewController()
        let navigationController = UINavigationController()
        navigationController.pushViewController(listViewController, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

