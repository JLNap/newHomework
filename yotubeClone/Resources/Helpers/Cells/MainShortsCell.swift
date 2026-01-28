//
//  MainShortsCell.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

protocol ShortsCellDelegate: AnyObject {
    func didTapShorts(at index: Int)
}

final class MainShortsCell: UICollectionViewCell {
    weak var delegate: ShortsCellDelegate?
    let shortsCollection: UICollectionView
    let logo = UIImageView()
    var shortsData: [Results] = [] {
        didSet { shortsCollection.reloadData() }
    }
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        shortsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        logo.image = UIImage(resource: .shortsImg)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        shortsCollection.dataSource = self
        shortsCollection.delegate = self
        shortsCollection.showsHorizontalScrollIndicator = false
        contentView.addSubview(shortsCollection)
        contentView.addSubview(logo)
        shortsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            logo.heightAnchor.constraint(equalToConstant: 50),
            
            shortsCollection.topAnchor.constraint(equalTo: logo.bottomAnchor),
            shortsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shortsCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        shortsCollection.register(ShortsCell.self, forCellWithReuseIdentifier: "ShortsCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainShortsCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shortsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapShorts(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortsCell", for: indexPath) as! ShortsCell
        cell.configure(with: shortsData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerScreen: CGFloat = 2.1
        let inset: CGFloat = 10
        let spacing: CGFloat = 10
        
        let totalSpacing = (itemsPerScreen - 1) * spacing + 2 * inset
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerScreen
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}
