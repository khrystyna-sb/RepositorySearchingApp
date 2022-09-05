//
//  SceneDelegate.swift
//  HeadwayTaskMatasova
//
//  Created by Roma Test on 04.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
//        navigationController.viewControllers = [loginViewController]
        
        
        navigationController.pushViewController(loginViewController, animated: false)

    }
}
