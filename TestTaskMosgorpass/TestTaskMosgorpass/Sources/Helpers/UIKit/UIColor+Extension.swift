//
//  UIColor+Extension.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import UIKit.UIColor

extension UIColor {
    /// The six-digit hexadecimal representation of color of the form #RRGGBB.
    /// - Parameters:
    ///   - hex6: Six-digit hexadecimal value.
    ///   - alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0.
    ///   Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
