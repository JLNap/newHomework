//
//  MainHeader.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 13.10.2025.
//

import UIKit

final class MainHeader: UIView {
    private let presenter: MainPresenterProtocol
    private let logoImg = UIImageView()
    private let tvShareBtn = UIButton(type: .system)
    private let alertBtn = UIButton(type: .system)
    private let searchBtn = UIButton(type: .system)
    private let avaBtn = UIButton(type: .system)
    private let horizontalDevider = DividerView()
    private let verticatDevider = DividerView(isVertical: true)
    private let contentContainerView = UIView()
    private let buttonsStack = UIStackView()
    private let mainStack = UIStackView()
    private let categories = [
        ButtonModel(title: "All", icon: nil),
        ButtonModel(title: "Alive", icon: nil),
        ButtonModel(title: "Dead", icon: nil),
        ButtonModel(title: "Unknown", icon: nil)
    ]
    private let filterView: FilterButtonsView
    private let exploreBtn = UIButton()
    
    init(frame: CGRect = .zero, presenter: MainPresenterProtocol) {
        self.presenter = presenter
        filterView = FilterButtonsView(models: categories)
        super.init(frame: frame)
        configure()
        setupView()
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let height = mainStack.frame.height + horizontalDevider.frame.height + filterView.frame.height + 20
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white

        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentContainerView)

        [logoImg, tvShareBtn, alertBtn, searchBtn, avaBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [ tvShareBtn, alertBtn, searchBtn, avaBtn ].forEach { buttonsStack.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(handleHeaderButtonTap(_:)), for: .touchUpInside)
        }

        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 18
      
        [logoImg, buttonsStack ].forEach { mainStack.addArrangedSubview($0) }
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .equalSpacing
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        exploreBtn.translatesAutoresizingMaskIntoConstraints = false
        exploreBtn.setTitle("Explore", for: .normal)
        exploreBtn.setImage(UIImage(systemName: "safari"), for: .normal)
        exploreBtn.tintColor = .black
        exploreBtn.backgroundColor = .devider
        exploreBtn.setTitleColor(.black, for: .normal)
        exploreBtn.layer.cornerRadius = 4
        exploreBtn.clipsToBounds = true
        exploreBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        exploreBtn.addTarget(self, action: #selector(handleExploreTap), for: .touchUpInside)
        
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.selectedIndex = 0
        filterView.onSelectionChanged?(0)
        filterView.onSelectionChanged = { [weak self] index in
            switch index {
            case 0: self?.presenter.resetFilter()
            case 1: self?.presenter.filterCharacters(by: .alive)
            case 2: self?.presenter.filterCharacters(by: .dead)
            case 3: self?.presenter.filterCharacters(by: .unknown)
            default:
                return
            }
        }
        
        contentContainerView.addSubview(mainStack)
        contentContainerView.addSubview(horizontalDevider)
        contentContainerView.addSubview(filterView)
        contentContainerView.addSubview(verticatDevider)
        contentContainerView.addSubview(exploreBtn)

        NSLayoutConstraint.activate([
            contentContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainerView.topAnchor.constraint(equalTo: topAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            mainStack.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            
            horizontalDevider.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 8),
            horizontalDevider.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            horizontalDevider.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
            
            exploreBtn.topAnchor.constraint(equalTo: horizontalDevider.bottomAnchor, constant: 10),
            exploreBtn.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            exploreBtn.bottomAnchor.constraint(equalTo: filterView.bottomAnchor),
            
            verticatDevider.leadingAnchor.constraint(equalTo: exploreBtn.trailingAnchor, constant: 10),
            verticatDevider.centerYAnchor.constraint(equalTo: filterView.centerYAnchor),
            verticatDevider.heightAnchor.constraint(equalToConstant: 30),
            
            filterView.topAnchor.constraint(equalTo: horizontalDevider.bottomAnchor, constant: 10),
            filterView.leadingAnchor.constraint(equalTo: verticatDevider.trailingAnchor, constant: 10),
            filterView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor)
        ])
    }
    
    func configure() {
        logoImg.image = .youtubeImg
        tvShareBtn.setImage(.tvShareImg, for: .normal)
        alertBtn.setImage(.alertImg, for: .normal)
        searchBtn.setImage(.searchImg, for: .normal)
        let avatar = UIImage(named: "avatarImg")?.withRenderingMode(.alwaysOriginal)
        avaBtn.setImage(avatar, for: .normal)
        
        [logoImg, tvShareBtn, alertBtn, searchBtn].forEach {
            $0.tintColor = .black
        }
    }
    
    @objc private func handleExploreTap() {
        let isRed = exploreBtn.backgroundColor == .red
        let newColor = isRed ? UIColor.devider : UIColor.red
        let newTitleColor = isRed ? UIColor.black : UIColor.white
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.exploreBtn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.exploreBtn.backgroundColor = newColor
            self.exploreBtn.setTitleColor(newTitleColor, for: .normal)
            self.exploreBtn.tintColor = newTitleColor
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
                self.exploreBtn.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc private func handleHeaderButtonTap(_ sender: UIButton) {
        let isRed = sender.backgroundColor == .red
        let newColor = isRed ? UIColor.clear : UIColor.red
        let newTintColor = isRed ? UIColor.black : UIColor.white
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            sender.backgroundColor = newColor
            sender.tintColor = newTintColor
            sender.layer.cornerRadius = 8
            sender.clipsToBounds = true
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
    }
}
