//
//  RealmService+DetailStation.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 24.05.2022.
//

import RealmSwift

extension RealmService: RealmServiceProtocol {
    func saveDetailStation(station: StationDetailRM) {
        saveObject(station)
    }
    
    func getDetailStations() -> [StationDetailRM]? {
        fetchObjects(objectType: StationDetailRM.self)
    }
    
    func deleteAll() {
        deleteObjects(type: StationDetailRM.self)
    }
}
