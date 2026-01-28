//
//  MainModuleBuilder 2.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

final class ShortsModuleBuilder {
    static func build(shorts: [Results], selectedIndex: Int) -> UIViewController {
        let presenter = ShortsPresenter(shorts: shorts)
        let router = MainRouter.shared
        let mainView = ShortsView(presenter: presenter, startIndex: selectedIndex, router: router)
        return mainView
    }
}
