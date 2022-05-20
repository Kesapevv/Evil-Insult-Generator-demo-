//
//  SceneDelegate.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //            if let windowScene = scene as? UIWindowScene {
        //
        //                let window = UIWindow(windowScene: windowScene)
        //                let navController = UINavigationController()
        //                let viewController = StartVC()
        //
        //                navController.viewControllers = [viewController]
        //                window.rootViewController = navController
        //                self.window = window
        //                window.makeKeyAndVisible()
        //            }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationContoller: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewContoller()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
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
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

