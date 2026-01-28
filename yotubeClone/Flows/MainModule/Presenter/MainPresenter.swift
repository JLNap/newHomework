//
//  MainPresenter.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    func loadCharacters()
    func filterCharacters(by status: CharacterStatus)
    var characters: [Results] { get }
    var onUpdate: (() -> Void)? { get set }
    func resetFilter()
    func getCurrentCharacters() -> [Results]
}

final class MainPresenter: MainPresenterProtocol {
    private let networkService: NetworkManagerProtocol
    weak var view: MainViewProtocol?
    private var allCharacters: [Results] = []
    var characters: [Results] = []
    var onUpdate: (() -> Void)?
    
    init(networkService: NetworkManagerProtocol) {
        self.networkService = networkService
    }
    
    func loadCharacters() {
        networkService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let chars):
                self?.allCharacters = chars
                self?.characters = chars
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            case .failure(let error):
                print("Error loading characters: \(error.localizedDescription)")
            }
        }
    }
    
    func getCurrentCharacters() -> [Results] {
        return characters
    }
    
    func filterCharacters(by status: CharacterStatus) {
        if status == .all {
            resetFilter()
        } else {
            characters = allCharacters.filter { $0.status == status.rawValue }
        }
        DispatchQueue.main.async {
            self.onUpdate?()
        }
    }
    
    func resetFilter() {
        characters = allCharacters
        DispatchQueue.main.async {
            self.onUpdate?()
        }
    }
}

