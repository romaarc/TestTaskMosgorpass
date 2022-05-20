//
//  BaseUICollectionReusableView.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 20.05.2022.
//

import UIKit

class BaseUICollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}

