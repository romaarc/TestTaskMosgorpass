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
        button.backgroundColor = .white
        button.titleLabel?.font = Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets.left = 16
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let rowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.rowFilterColor
        view.layer.cornerRadius = 2.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        return separator
    }()
    
    override func setupView() {
        [button, rowView, separator].forEach { addSubview($0) }
    }
    
    override func setupLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(36)
            make.height.equalTo(5)
            make.centerX.equalToSuperview()
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
