//
//  TabBar.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 14.10.2025.
//

import UIKit

final class TabBar: UITabBarController, UITabBarControllerDelegate {
    
    private let mainPresenter: MainPresenterProtocol
    
    init(mainPresenter: MainPresenterProtocol) {
        self.mainPresenter = mainPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let home = UINavigationController(rootViewController: MainModuleBuilder.build())
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let shorts = UIViewController()
        shorts.tabBarItem = UITabBarItem(title: "Shorts", image: UIImage(systemName: "play.rectangle"), tag: 1)
        
        let addContent = MainModuleBuilder.build()
        addContent.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle"), tag: 2)
        
        let subs = MainModuleBuilder.build()
        subs.tabBarItem = UITabBarItem(title: "Subs", image: UIImage(systemName: "person.2"), tag: 3)
        
        let lib = MainModuleBuilder.build()
        lib.tabBarItem = UITabBarItem(title: "Lib", image: UIImage(systemName: "books.vertical"), tag: 4)
        
        viewControllers = [home, shorts, addContent, subs, lib]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.title == "Shorts" {
            let randomIndex = Int.random(in: 0..<max(mainPresenter.characters.count, 1))
            MainRouter.shared.pushShortsDetail(shorts: mainPresenter.characters, selectedIndex: randomIndex)
        }
    }
}

