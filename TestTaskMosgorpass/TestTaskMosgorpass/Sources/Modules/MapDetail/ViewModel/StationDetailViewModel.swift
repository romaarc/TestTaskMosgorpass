//
//  StationDetailViewModel.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 23.05.2022.
//

import Foundation

struct StationDetailViewModel: Decodable {
    let id, name, type, color: String
    let routePath: [RoutePath]
}
