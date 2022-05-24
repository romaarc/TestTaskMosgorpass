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

extension StationViewModel {
    init(
        id: String,
        lat: Double,
        lon: Double
    ) {
        self.id = id
        self.lon = lon
        self.lat = lat
        self.name = ""
        self.type = .publicTransport
        self.routeNumber = nil
        self.color = nil
        self.routeName = nil
        self.subwayID = nil
        self.shareURL = ""
        self.wifi = false
        self.usb = false
        self.transportType = nil
        self.transportTypes = [TypeElement]()
        self.isFavorite = false
        self.icon = nil
        self.mapIcon = nil
        self.mapIconSmall = nil
        self.cityShuttle = false
        self.electrobus = false
    }
}
