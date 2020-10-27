//
//  SceneDelegate.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createNavigationController()
        configureNavigationBar()
        window?.makeKeyAndVisible()
        
       
    }
    
    func createNavigationController() -> UINavigationController {
        let thMainVC = THMainVC()
        thMainVC.title = "Top Headlines"
        thMainVC.navigationController?.navigationBar.backgroundColor = .systemRed
        
        return UINavigationController(rootViewController: thMainVC)
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = Colors.titleBlue
        
        let attributes = [
                NSAttributedString.Key.font: UIFont(name: "DMSerifText-Regular", size: 22)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        UINavigationBar.appearance().titleTextAttributes = attributes
  
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


}

