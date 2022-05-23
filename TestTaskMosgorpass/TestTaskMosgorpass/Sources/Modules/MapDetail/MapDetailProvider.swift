import Foundation
import PromiseKit

protocol MapDetailProviderProtocol {
    func fetchById(withID id: String) -> Promise<StationDetail>
}

final class MapDetailProvider: MapDetailProviderProtocol {
    private let mosgorpassNetworkService: NetworkServiceProtocol
    
    init(mosgorpassNetworkService: NetworkServiceProtocol) {
        self.mosgorpassNetworkService = mosgorpassNetworkService
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
    
    enum Error: Swift.Error {
        case stationDetailDataFetchFailed
    }
}
