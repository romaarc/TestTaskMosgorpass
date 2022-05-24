//
//  StationDetailRM.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 24.05.2022.
//

import RealmSwift

class StationDetailRM: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var isWasViewed: Bool
    @Persisted var lat: Double
    @Persisted var lon: Double
    
    convenience init(
        id: String,
        isWasViewed: Bool,
        lat: Double,
        lon: Double
    ) {
        self.init()
        self.id = id
        self.isWasViewed = isWasViewed
        self.lat = lat
        self.lon = lon
    }
}
