//
//  SceneDelegate.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let mainPresenter = MainPresenter(networkService: NetworkManager())
        mainPresenter.loadCharacters()
        
        let tabBar = TabBar(mainPresenter: mainPresenter)
        let navigationController = UINavigationController(rootViewController: tabBar)
        
        window.rootViewController = navigationController
        
        MainRouter.shared.setRootNavigationController(navigationController)
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

