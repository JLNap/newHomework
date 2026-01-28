//
//  MainModuleBuilder.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

final class MainModuleBuilder {
    static func build() -> UIViewController {
        let networkManager = NetworkManager()
        let presenter = MainPresenter(networkService: networkManager)
        let mainView = MainView(presenter: presenter)
        return mainView
    }
}
