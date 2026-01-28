//
//  ShortsModuleCell.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.

import UIKit

final class ShortsModuleCell: UICollectionViewCell {
    
    private let shortsImageView = UIImageView()
    private let stack = UIStackView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let subscribeButton = CustomButtonView(title: "SUBSCRIBE", backgroundColor: .red, titleColor: .white)
    private let authorStack = UIStackView()
    private let verticalStack = UIStackView()
    private let titleLabel = UILabel()
    private var shortsButtons: [ShortsButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 32/2
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        [verticalStack, stack].forEach {
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowRadius = 4
        }
        
        authorStack.axis = .horizontal
        authorStack.alignment = .center
        authorStack.spacing = 8
        [avatarImageView, nameLabel, subscribeButton].forEach { authorStack.addArrangedSubview($0) }
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .white
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 10
        [titleLabel, authorStack].forEach { verticalStack.addArrangedSubview($0) }
        
        shortsImageView.contentMode = .scaleAspectFill
        shortsImageView.clipsToBounds = true
        
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 18
        
        let btns: [ShortsButtonsModel] = Constants.shared.shortsBtns.compactMap { title, iconName in
            guard let icon = UIImage(named: iconName) else { return nil }
            return ShortsButtonsModel(title: title, icon: icon)
        }
        
        btns.forEach { btn in
            let button = ShortsButton(model: btn)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
            shortsButtons.append(button)
            stack.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(greaterThanOrEqualToConstant: 56),
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
            ])
        }
        
        subscribeButton.addTarget(self, action: #selector(handleSubscribeTap), for: .touchUpInside)
        
        [avatarImageView, authorStack, stack, shortsImageView, verticalStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(shortsImageView)
        contentView.addSubview(verticalStack)
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            shortsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shortsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.widthAnchor.constraint(lessThanOrEqualToConstant: 80)
        ])
    }
    
    @objc private func handleButtonTap(_ sender: ShortsButton) {
        let newColor = sender.tintColor == .red ? UIColor.white : UIColor.red
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            sender.tintColor = newColor
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc private func handleSubscribeTap() {
        let isSubscribed = subscribeButton.getBackgroundColor() == .white
        let newBackgroundColor = isSubscribed ? UIColor.red : UIColor.white
        let newTitleColor = isSubscribed ? UIColor.white : UIColor.black
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.subscribeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.subscribeButton.setBackgroundColor(newBackgroundColor)
            self.subscribeButton.setTitleColor(newTitleColor)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
                self.subscribeButton.transform = CGAffineTransform.identity
            })
        }
    }
    
    func configure(with result: Results) {
        titleLabel.text = result.name
        nameLabel.text = result.status
        if let url = URL(string: result.image) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.shortsImageView.image = image
                self?.avatarImageView.image = image
            }
        }
    }
}
