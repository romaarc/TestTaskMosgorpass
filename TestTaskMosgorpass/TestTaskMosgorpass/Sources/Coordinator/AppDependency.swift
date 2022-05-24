//
//  AppDependency.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

protocol HasDependencies {
    var mosgorpassNetworkService: NetworkServiceProtocol { get }
    var stationDetailRealmService: RealmServiceProtocol { get }
}

///class AppDependency - зависимость контейнер с сервисами, для передачи в модули VIP
final class AppDependency {
    let networkService: NetworkService
    let realmService: RealmService

    init(
        networkService: NetworkService,
        realmService: RealmService
    ) {
        self.networkService = networkService
        self.realmService = realmService
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        let realmService = RealmService()
        return AppDependency(networkService: networkService, realmService: realmService)
    }
}

extension AppDependency: HasDependencies {
    var mosgorpassNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
    var stationDetailRealmService: RealmServiceProtocol {
        return self.realmService
    }
}
