import Foundation
import PromiseKit

protocol StationInteractorProtocol {
    func doStationsUpdate(request: StationLoad.StationUpdate.Request)
    func doFindingDetailStation(request: StationLoad.StationUpdate.Request)
    func doDetailStationDelete(request: StationLoad.StationUpdate.Request) 
}

final class StationInteractor: StationInteractorProtocol {
    weak var moduleOutput: StationOutputProtocol?
    
    private let presenter: StationPresenterProtocol
    private let provider: StationProviderProtocol
    
    init(
        presenter: StationPresenterProtocol,
        provider: StationProviderProtocol
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func doStationsUpdate(request: StationLoad.StationUpdate.Request) {
        provider.fetch().then { stations -> Promise<[Station]> in
            self.provider.deleteObjects()
            return .value(stations)
        }.done { stations in
            self.presenter.presentStationsResult(response: .init(result: .success(stations)))
        }.catch { _ in
            self.presenter.presentStationsResult(response: .init(result: .failure(Error.unloadable)))
        }
    }
    
    func doFindingDetailStation(request: StationLoad.StationUpdate.Request) {
        let objects: [StationDetailRM] = provider.fetchObjects()
        if !objects.isEmpty {
            presenter.presentDetailStationResult(response: .init(result: .success(objects)))
        } else {
            doStationsUpdate(request: .init())
        }
    }
    
    func doDetailStationDelete(request: StationLoad.StationUpdate.Request) {
        provider.deleteObjects()
    }
    
    enum Error: Swift.Error {
        case unloadable
    }
}

extension StationInteractor: StationInputProtocol { }
