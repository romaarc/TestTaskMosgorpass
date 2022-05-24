import Foundation
import PromiseKit

protocol MapDetailInteractorProtocol {
    func doStationUpdate(request: MapDetailLoad.StationDetailUpdate.Request)
}

final class MapDetailInteractor: MapDetailInteractorProtocol {
    weak var moduleOutput: MapDetailOutputProtocol?
    
    private let presenter: MapDetailPresenterProtocol
    private let provider: MapDetailProviderProtocol
    
    init(
        presenter: MapDetailPresenterProtocol,
        provider: MapDetailProviderProtocol
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func doStationUpdate(request: MapDetailLoad.StationDetailUpdate.Request) {
        provider.fetchById(withID: request.data.id).then { stationDetail -> Promise<StationDetail> in
            self.doStationSave(stationDetail)
            return .value(stationDetail)
        }.done { stationDetail in
            self.presenter.presentStationResult(response: .init(result: .success(stationDetail)))
        }.catch { _ in
            self.presenter.presentStationResult(response: .init(result: .failure(Error.unloadable)))
        }
    }
    
    func doStationSave(_ model: StationDetail) {
        provider.saveIdToRealm(model)
    }
    
    enum Error: Swift.Error {
        case unloadable
    }
}

extension MapDetailInteractor: MapDetailInputProtocol { }
