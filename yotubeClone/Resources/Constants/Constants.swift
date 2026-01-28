//
//  Constants.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

final class Constants {
    static let shared = Constants()
    
    private init() { }
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    var characters: String { baseUrl + "character" }
    let shortsBtns: [(String?, String)] = [
        (nil, "shortsActBtn"),
        ("245K", "likeBtn"),
        ("Dislike", "dislikeBtn"),
        ("952", "commentBtn"),
        (nil, "idkBtn")
    ]
}
