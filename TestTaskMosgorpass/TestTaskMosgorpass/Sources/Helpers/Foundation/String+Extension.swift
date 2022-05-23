//
//  String+Extension.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 23.05.2022.
//

import Foundation
extension String {
    func arrivingForRussian(count: UInt) -> String {
        if (count == 0) {
            return "Автобус прибыл"
        } else if (count % 10 == 1 && count % 100 != 11) {
          return String.init(format:  "Прибывает через %u минуту", count)
        } else if ((count % 10 >= 2 && count % 10 <= 4) &&
            !(count % 100 >= 12 && count % 100 <= 14)) {
            return String.init(format: "Прибывает через %u минуты", count)
        } else if (count % 10 == 0 || (count % 10 >= 5 && count % 10 <= 9) ||
            (count % 100 >= 11 && count % 100 <= 14)) {
            return String.init(format: "Прибывает через %u минут", count)
        }
        return "Автобус прибыл"
    }
}
