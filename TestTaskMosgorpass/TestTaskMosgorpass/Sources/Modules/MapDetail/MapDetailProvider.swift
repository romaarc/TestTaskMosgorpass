import Foundation
import PromiseKit

protocol MapDetailProviderProtocol {
    func fetchById(withID id: String) -> Promise<StationDetail>
    func saveIdToRealm(_ model: StationDetail)
}

final class MapDetailProvider: MapDetailProviderProtocol {
    
    private let mosgorpassNetworkService: NetworkServiceProtocol
    private let stationDetailRealmService: RealmServiceProtocol
    
    init(
        mosgorpassNetworkService: NetworkServiceProtocol,
        stationDetailRealmService: RealmServiceProtocol
    ) {
        self.mosgorpassNetworkService = mosgorpassNetworkService
        self.stationDetailRealmService = stationDetailRealmService
    }
    
    func fetchById(withID id: String) -> Promise<StationDetail> {
        Promise { seal in
            self.mosgorpassNetworkService.fetchById(withID: id).done { response in
                seal.fulfill(response)
            }.catch() { _ in
                seal.reject(Error.stationDetailDataFetchFailed)
            }
        }
    }
    
    func saveIdToRealm(_ model: StationDetail) {
        let station = StationDetailRM(
            id: model.id,
            isWasViewed: true,
            lat: model.lat,
            lon: model.lon)
        stationDetailRealmService.saveDetailStation(station: station)
    }
    
    enum Error: Swift.Error {
        case stationDetailDataFetchFailed
    }
}
