//
//  RealmServiceProtocol.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 24.05.2022.
//

import Foundation

protocol RealmServiceProtocol {
    func saveDetailStation(station: StationDetailRM)
    func getDetailStations() -> [StationDetailRM]?
    func deleteAll()
}
