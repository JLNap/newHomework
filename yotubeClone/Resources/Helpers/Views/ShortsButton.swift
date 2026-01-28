//
//  ShortsButton.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

final class ShortsButton: UIButton {
    
    init(model: ShortsButtonsModel) {
        super.init(frame: .zero)
        
        let templateImage = model.icon.withRenderingMode(.alwaysTemplate)
        setImage(templateImage, for: .normal)
        setTitle(model.title, for: .normal)
        
        tintColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        layer.cornerRadius = 12
        clipsToBounds = true
        backgroundColor = .clear
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 6
        config.imagePlacement = .top
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





