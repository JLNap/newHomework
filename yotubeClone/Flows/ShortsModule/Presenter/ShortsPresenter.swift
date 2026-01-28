//
//  ShortsPresenter.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

protocol ShortsPresenterProtocol {
    var shorts: [Results] { get }
    func loadShorts()
}

final class ShortsPresenter: ShortsPresenterProtocol {
    var shorts: [Results]
    var onUpdate: (() -> Void)?

    init(shorts: [Results]) {
        self.shorts = shorts
    }

    func loadShorts() {
        DispatchQueue.main.async {
            self.onUpdate?()
        }
    }
}
