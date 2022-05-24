import Foundation
import PromiseKit

protocol StationProviderProtocol {
    func fetch() -> Promise<[Station]>
    func fetchObjects() -> [StationDetailRM]
    func deleteObjects()
}

final class StationProvider: StationProviderProtocol {
    private let mosgorpassNetworkService: NetworkServiceProtocol
    private let stationDetailRealmService: RealmServiceProtocol
    
    init(
        mosgorpassNetworkService: NetworkServiceProtocol,
        stationDetailRealmService: RealmServiceProtocol
    ) {
        self.mosgorpassNetworkService = mosgorpassNetworkService
        self.stationDetailRealmService = stationDetailRealmService
    }
    
    func fetch() -> Promise<[Station]> {
        Promise { seal in
            self.mosgorpassNetworkService.fetch().done { response in
                seal.fulfill(response.data)
            }.catch() { _ in
                seal.reject(Error.stationsDataFetchFailed)
            }
        }
    }
    
    func fetchObjects() -> [StationDetailRM] {
        stationDetailRealmService.getDetailStations() ?? [StationDetailRM]()
    }
    
    func deleteObjects() {
        stationDetailRealmService.deleteAll()
    }
    
    enum Error: Swift.Error {
        case stationsDataFetchFailed
    }
}
