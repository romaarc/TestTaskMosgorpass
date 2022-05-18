import Foundation
import PromiseKit

protocol StationInteractorProtocol {
    func doSomeAction(request: StationLoad.SomeAction.Request)
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

    func doSomeAction(request: StationLoad.SomeAction.Request) { }

    enum Error: Swift.Error {
        case something
    }
}

extension StationInteractor: StationInputProtocol { }
