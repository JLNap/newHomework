//
//  ViewController.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func updateUI()
}

class MainView: UIViewController, MainViewProtocol {
    
    private let presenter: MainPresenterProtocol
    private var collectionView: UICollectionView!
    private let header: MainHeader
    private let router = MainRouter.shared
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        self.header = MainHeader(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func updateUI() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.reloadData()
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(MainVideoCell.self, forCellWithReuseIdentifier: "MainVideoCell")
        collectionView.register(MainShortsCell.self, forCellWithReuseIdentifier: "MainShortsCell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .devider
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presenter.onUpdate = { [weak self] in
            self?.updateUI()
        }
        
        presenter.loadCharacters()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize: NSCollectionLayoutSize
            let isShortsCell = self.presenter.characters.indices.contains(1)
            
            if isShortsCell {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(360)
                )
            } else {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(300)
                )
            }
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 6
            
            return section
        }
    }
}

extension MainView: UICollectionViewDataSource, ShortsCellDelegate {
    
    func didTapShorts(at index: Int) {
        let shorts = presenter.characters
        router.pushShortsDetail(shorts: shorts, selectedIndex: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainShortsCell", for: indexPath) as? MainShortsCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.shortsData = presenter.characters
            cell.backgroundColor = .white
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainVideoCell", for: indexPath) as? MainVideoCell else {
                return UICollectionViewCell()
            }
            let character = presenter.characters[indexPath.item]
            cell.configure(with: character)
            cell.backgroundColor = .white
            return cell
        }
    }
}
