//
//  NetworkModel.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import Foundation

enum CharacterStatus: String {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct NetworkModel: Decodable{
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
    let name: String
    let gender: String
    let image: String
    let status: String
}
