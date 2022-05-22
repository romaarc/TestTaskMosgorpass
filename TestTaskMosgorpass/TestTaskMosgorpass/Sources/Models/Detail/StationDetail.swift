//
//  Detail.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 21.05.2022.
//

import Foundation

struct StationDetail: Decodable {
    let id, name, type: String
    let wifi: Bool
    let bench, elevator: Bool?
    let photo: String?
    let commentTotalCount: Int
    let routePath: [RoutePath]
    let color, routeNumber: String
    let isFavorite: Bool
    let shareURL: String
    let lat, lon: Double
    let cityShuttle, electrobus: Bool
    let transportTypes: [String]
    let routeName, shuttleType: String?
    let regional: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, type, wifi, bench, elevator, photo, commentTotalCount, routePath, color, routeNumber, isFavorite
        case shareURL = "shareUrl"
        case lat, lon, cityShuttle, electrobus, transportTypes, routeName, shuttleType, regional
    }
}

struct RoutePath: Decodable {
    let id, routePathID, type, number: String
    let timeArrivalSecond: [Int]
    let timeArrival: [String]
    let lastStopName: String
    let isFifa, weight, byTelemetry: Int
    let color, fontColor: String
    let cityShuttle, electrobus: Bool
    let tmIDS: [Int]
    let externalForecastTime: [ExternalForecastTime]
    let byTelemetryArray: [Int]
    let routePathIDS, feature: String?
    let sberShuttle, isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case routePathID = "routePathId"
        case type, number, timeArrivalSecond, timeArrival, lastStopName, isFifa, weight, byTelemetry, color, fontColor, cityShuttle, electrobus
        case tmIDS = "tmIds"
        case externalForecastTime, byTelemetryArray
        case routePathIDS = "routePathIds"
        case feature, sberShuttle, isFavorite
    }
}

struct ExternalForecastTime: Decodable {
    let time, byTelemetry, tmID: Int
    let routePathID: String

    enum CodingKeys: String, CodingKey {
        case time, byTelemetry
        case tmID = "tmId"
        case routePathID = "routePathId"
    }
}
