//
//  StationViewModel.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

struct StationViewModel: Decodable {
    let id: String
    let lat, lon: Double
    let name: String
    let type: TypeElement
    let routeNumber, color, routeName, subwayID: String?
    let shareURL: String
    let wifi, usb: Bool
    let transportType: String?
    let transportTypes: [TypeElement]
    let isFavorite: Bool
    let icon: String?
    let mapIcon: String?
    let mapIconSmall: String?
    let cityShuttle, electrobus: Bool
}
