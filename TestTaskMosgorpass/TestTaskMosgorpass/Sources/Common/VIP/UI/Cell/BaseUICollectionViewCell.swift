//
//  BaseUICollectionViewCell.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 19.05.2022.
//

import UIKit

class BaseUICollectionViewCell: UICollectionViewCell {
    
    var shadowColor: UIColor = StationConstants.Design.shadowColor
    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 0
    var shadowOpacity: Float = 0
    var shadowOffsetWidth: CGFloat = 0
    var shadowOffsetHeight: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
    
    func setupShadow() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Colors.borderLightGray.cgColor
        contentView.layer.cornerRadius = cornerRadius
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
       
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor

        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    }
}
