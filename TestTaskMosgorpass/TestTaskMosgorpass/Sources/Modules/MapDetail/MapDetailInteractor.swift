import Foundation
import PromiseKit

protocol MapDetailInteractorProtocol {
    func doSomeAction(request: MapDetail.SomeAction.Request)
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

    func doSomeAction(request: MapDetail.SomeAction.Request) { }

    enum Error: Swift.Error {
        case something
    }
}

extension MapDetailInteractor: MapDetailInputProtocol { }