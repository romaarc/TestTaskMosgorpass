//
//  HeaderView.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 22.05.2022.
//

import UIKit
import SnapKit

extension HeaderView {
    struct Appearance {
        let buttonTintColor = UIColor.black
        let buttonBackgroundColor = UIColor.white
        let buttonTitleLabelFont = Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        let buttonContentEdgeInsetsLeft: CGFloat = 10
        let separatorBackgroundColor = UIColor(white: 0.8, alpha: 0.5)
        let rowViewBackgroundColor = Colors.rowFilterColor
        let rowViewCornerRadius = 2.5
    }
}

final class HeaderView: UIView {
    let appearance: Appearance
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let rowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)

        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(someText text: String) {
        button.setTitle("Остановка - \(text)", for: .normal)
    }
}

extension HeaderView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        button.tintColor = appearance.buttonTintColor
        button.backgroundColor = appearance.buttonBackgroundColor
        button.titleLabel?.font = appearance.buttonTitleLabelFont
        button.contentEdgeInsets.left = appearance.buttonContentEdgeInsetsLeft
        separator.backgroundColor = appearance.separatorBackgroundColor
        rowView.backgroundColor = appearance.rowViewBackgroundColor
        rowView.layer.cornerRadius = appearance.rowViewCornerRadius
    }
    func addSubviews() {
        [button, rowView, separator].forEach { addSubview($0) }
    }
    func makeConstraints() {
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
}
