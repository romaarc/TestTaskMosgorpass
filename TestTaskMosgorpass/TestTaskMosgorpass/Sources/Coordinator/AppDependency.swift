//
//  AppDependency.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

protocol HasDependencies {
    var mosgorpassNetworkService: NetworkServiceProtocol { get }
}

///class AppDependency - зависимость контейнер с сервисами, для передачи в модули VIP
final class AppDependency {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        return AppDependency(networkService: networkService)
    }
}

extension AppDependency: HasDependencies {
    var mosgorpassNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
}
