//
//  DividerView.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 14.10.2025.
//

import UIKit

final class DividerView: UIView {
    init(color: UIColor = .lightGray, lineSize: CGFloat = 1.0, isVertical: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isVertical
                ? widthAnchor.constraint(equalToConstant: lineSize)
                : heightAnchor.constraint(equalToConstant: lineSize)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
