//
//  Response.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: [T]
}
