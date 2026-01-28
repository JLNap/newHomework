//
//  ShortsView.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

protocol ShortsViewProtocol {
    func updateUI()
}

final class ShortsView: UIViewController, ShortsViewProtocol {

    private let presenter: ShortsPresenterProtocol
    private let header = ShortsHeader()
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private let startIndex: Int
    private let router: MainRouter
    
    init(presenter: ShortsPresenterProtocol, startIndex: Int = 0, router: MainRouter) {
        self.presenter = presenter
        self.startIndex = startIndex
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(collectionView)
        setupUI()
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: self.startIndex, section: 0), at: .centeredVertically, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        header.setBackButtonAction(self, action: #selector(onBackPressed))
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = view.bounds.size
        
        collectionView.register(ShortsModuleCell.self, forCellWithReuseIdentifier: "ShortsModuleCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateUI() {
        collectionView.reloadData()
    }
    
    @objc
    func onBackPressed() {
        if let tabBar = navigationController?.viewControllers.first as? UITabBarController {
            tabBar.selectedIndex = 0
        }
        router.pop()
    }
}

extension ShortsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.shorts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortsModuleCell", for: indexPath) as? ShortsModuleCell else {
            return UICollectionViewCell()
        }
        let shortItem = presenter.shorts[indexPath.item]
        cell.configure(with: shortItem)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let headerHeight: CGFloat = 60
        let topSafeArea: CGFloat = view.safeAreaInsets.top
        let totalHeaderHeight = headerHeight + topSafeArea
        return CGSize(width: view.bounds.width, height: view.bounds.height - totalHeaderHeight)
    }
}


