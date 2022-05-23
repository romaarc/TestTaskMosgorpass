//
//  HeaderView.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 22.05.2022.
//

import UIKit
import SnapKit

final class HeaderView: BaseView {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = Colors.lightWhite
        button.titleLabel?.font = Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets.left = 16
        return button
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        return separator
    }()
    
    override func setupView() {
        addSubview(button)
    }
    
    override func setupLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1 / UIScreen.main.scale)
        }
    }
    
    func update(someText text: String) {
        button.setTitle(text, for: .normal)
    }
}
