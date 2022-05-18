//
//  API.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation
/// enum API содержит в себе основной линк на апи и подтипы
enum API {
    static let main = "https://api.mosgorpass.ru/v8.2"
    
    enum TypeOf {
        static let stops = "/stop"
    }
}
