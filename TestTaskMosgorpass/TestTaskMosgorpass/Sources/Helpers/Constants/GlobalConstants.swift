//
//  GlobalConstants.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 19.05.2022.
//

import UIKit

struct StationConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 80
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 16
        static let spacingLeft: CGFloat = 16
        static let spacingTop: CGFloat = 19
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 16
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.1
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
    
    struct Strings {
        static let emptyMessage = "Не найдено станций или подключитесь к сети, чтобы загрузить данные.."
        static let emptyDetailMessage = "Не найдено транспорта или подключитесь к сети, чтобы загрузить данные.."
    }
}
