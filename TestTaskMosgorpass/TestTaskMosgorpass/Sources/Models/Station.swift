//
//  Station.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

enum TypeElement: String, Decodable {
    case bus = "bus"
    case mcd = "mcd"
    case publicTransport = "public_transport"
    case subwayHall = "subwayHall"
    case train = "train"
    case tram = "tram"
    
    var title: String {
        switch self {
        case .bus:
            return "Автобус"
        case .mcd:
            return "МЦД"
        case .publicTransport:
            return "Все виды транспорта"
        case .subwayHall:
            return "Зал метро"
        case .train:
            return "Троллейбус"
        case .tram:
            return "Трамвай"
        }
    }
}

struct Station: Decodable {
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

    enum CodingKeys: String, CodingKey {
        case id, lat, lon, name, type, routeNumber, color, routeName
        case subwayID = "subwayId"
        case shareURL = "shareUrl"
        case wifi, usb, transportType, transportTypes, isFavorite, icon, mapIcon, mapIconSmall, cityShuttle, electrobus
    }
}
