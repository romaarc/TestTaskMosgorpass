import Foundation
import PromiseKit

protocol StationInteractorProtocol {
    func doStationsUpdate(request: StationLoad.StationUpdate.Request)
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
        provider.fetch().done { stations in
            self.presenter.presentStationsResult(response: .init(result: .success(stations)))
        }.catch { _ in
            self.presenter.presentStationsResult(response: .init(result: .failure(Error.unloadable)))
        }
    }
    
    enum Error: Swift.Error {
        case unloadable
    }
}

extension StationInteractor: StationInputProtocol { }
