//
//  SubscribeButton.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 17.10.2025.
//

import UIKit

class CustomButtonView: UIView {

    private let button = UIButton(type: .system)
    private var action: (() -> Void)?

    init(title: String, backgroundColor: UIColor = .systemBlue, titleColor: UIColor = .white, action: (() -> Void)? = nil) {
        self.action = action
        super.init(frame: .zero)
        setupButton(title: title, backgroundColor: backgroundColor, titleColor: titleColor)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(title: "Button", backgroundColor: .systemBlue, titleColor: .white)
    }

    private func setupButton(title: String, backgroundColor: UIColor, titleColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    func setBackgroundColor(_ color: UIColor) {
        button.backgroundColor = color
    }

    func setTitleColor(_ color: UIColor) {
        button.setTitleColor(color, for: .normal)
    }

    func getBackgroundColor() -> UIColor? {
        button.backgroundColor
    }
    @objc private func buttonTapped() {
        action?()
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
}
