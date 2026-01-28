//
//  MainRouter.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 17.10.2025.
//

import UIKit

final class MainRouter {
    static let shared = MainRouter()
    
    private init() {}
    
    var navigationController: UINavigationController?
    
    func setRootNavigationController(_ navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pushShortsDetail(shorts: [Results], selectedIndex: Int) {
        let vc = ShortsModuleBuilder.build(shorts: shorts, selectedIndex: selectedIndex)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
