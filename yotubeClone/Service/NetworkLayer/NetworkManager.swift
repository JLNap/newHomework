//
//  NetworkManager.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

protocol NetworkManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<[Results], Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    func fetchCharacters(completion: @escaping (Result<[Results], Error>) -> Void) {
        let urlString = Constants.shared.characters
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let decoded = try JSONDecoder().decode(NetworkModel.self, from: data)
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
