import Foundation
import PromiseKit

protocol StationProviderProtocol {
    func fetch() -> Promise<[Station]>
}

final class StationProvider: StationProviderProtocol {
    private let mosgorpassNetworkService: NetworkServiceProtocol
    
    init(mosgorpassNetworkService: NetworkServiceProtocol) {
        self.mosgorpassNetworkService = mosgorpassNetworkService
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
    
    enum Error: Swift.Error {
        case stationsDataFetchFailed
    }
}
