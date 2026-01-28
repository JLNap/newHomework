//
//  MainVideoCell.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

final class ShortsCell: UICollectionViewCell {
    private let previewImg = UIImageView()
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
        [titleLabel, statLabel].forEach {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 12, weight: .bold)
            $0.shadowColor = UIColor.black.withAlphaComponent(0.5)
            $0.shadowOffset = CGSize(width: 0.5, height: 0.5)
        }
        
        if let url = URL(string: data.image) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.previewImg.image = image
            }
        }
        
        actionsBtn.setImage(UIImage(named: "videoActionBtnImg"), for: .normal)
        actionsBtn.tintColor = .white
    }
    
    private func setupViews() {
        [previewImg, titleLabel, statLabel, actionsBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        previewImg.contentMode = .scaleAspectFill
        previewImg.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            titleLabel.bottomAnchor.constraint(equalTo: previewImg.bottomAnchor, constant: -32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            statLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            statLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            actionsBtn.topAnchor.constraint(equalTo: previewImg.topAnchor, constant: 12),
            actionsBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            actionsBtn.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
