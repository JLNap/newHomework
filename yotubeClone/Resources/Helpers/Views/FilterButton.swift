//
//  FilterButton.swift
//  yotubeClone
//
//  Created by Андрей Чучупал on 15.10.2025.
//

import UIKit

final class FilterButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .darkGray : .lightGray
            setTitleColor(isSelected ? .white : .black, for: .normal)
        }
    }

    init(model: ButtonModel) {
        super.init(frame: .zero)
        setTitle(model.title, for: .normal)
        setImage(model.icon, for: .normal)
        layer.cornerRadius = 18
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        backgroundColor = .lightGray
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .selected)
        clipsToBounds = true
        minimumWidthConstraint()
    }
    
    private func minimumWidthConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }

    required init?(coder: NSCoder) { fatalError() }
}

final class FilterButtonsView: UIView {
    var onSelectionChanged: ((Int) -> Void)?
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    private var buttons: [FilterButton] = []
    var selectedIndex: Int = 0 {
        didSet {
            for (i, btn) in buttons.enumerated() {
                btn.isSelected = (i == selectedIndex)
            }
        }
    }
    
    init(models: [ButtonModel]) {
        super.init(frame: .zero)
        
        scroll.showsHorizontalScrollIndicator = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        addSubview(scroll)
        
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        ])
        
        let trailingConstraint = stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor)
        trailingConstraint.priority = UILayoutPriority(250)
        trailingConstraint.isActive = true
        
        buttons = models.map { model in
            let btn = FilterButton(model: model)
            btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(btn)
            return btn
        }
        
        selectedIndex = 0
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
         guard let index = buttons.firstIndex(of: sender as! FilterButton) else { return }
         selectedIndex = index
         onSelectionChanged?(index)
     }
    
    required init?(coder: NSCoder) { fatalError() }
}

