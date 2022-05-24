//
//  UICollectionView+Empty.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 20.05.2022.
//

import UIKit

extension UICollectionView {
    func setEmptyMessage(message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .regular)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
