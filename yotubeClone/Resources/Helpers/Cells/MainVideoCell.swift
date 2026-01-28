//
//  MainVideoCell.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

final class MainVideoCell: UICollectionViewCell {
    private let previewImg = UIImageView()
    private let profileImg = UIImageView()
    private let titleLabel = UILabel()
    private let statLabel = UILabel()
    private let actionsBtn = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: Results) {
        titleLabel.text = data.name
        statLabel.text = data.status
        statLabel.textColor = .lightGray
        
        if let url = URL(string: data.image) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.previewImg.image = image
                self?.profileImg.image = image
            }
        }
        
        actionsBtn.setImage(UIImage(named: "videoActionBtnImg"), for: .normal)
        actionsBtn.tintColor = .black
    }
    
    private func setupViews() {
        [previewImg, profileImg, titleLabel, statLabel, actionsBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        profileImg.layer.cornerRadius = 18
        profileImg.clipsToBounds = true
        
        previewImg.contentMode = .scaleAspectFill
        previewImg.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImg.heightAnchor.constraint(equalToConstant: 215),
            
            profileImg.topAnchor.constraint(equalTo: previewImg.bottomAnchor, constant: 14),
            profileImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profileImg.heightAnchor.constraint(equalToConstant: 36),
            profileImg.widthAnchor.constraint(equalTo: profileImg.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: previewImg.bottomAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: actionsBtn.leadingAnchor, constant: -12),
            
            statLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            statLabel.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 12),
            statLabel.trailingAnchor.constraint(equalTo: actionsBtn.leadingAnchor, constant: -12),
            
            actionsBtn.topAnchor.constraint(equalTo: previewImg.bottomAnchor, constant: 14),
            actionsBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            actionsBtn.heightAnchor.constraint(equalToConstant: 24),
            actionsBtn.widthAnchor.constraint(equalTo: actionsBtn.heightAnchor)
        ])
    }
}
