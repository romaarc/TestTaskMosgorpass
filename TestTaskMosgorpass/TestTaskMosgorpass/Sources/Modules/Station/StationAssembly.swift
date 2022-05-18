import UIKit

final class StationAssembly: Assembly {
    var moduleInput: StationInputProtocol?

    private weak var moduleOutput: StationOutputProtocol?

    init(output: StationOutputProtocol? = nil) {
        self.moduleOutput = output
    }

    func makeModule(with context: ModuleContext?) -> UIViewController {
        let provider = StationProvider()
        let presenter = StationPresenter()
        let interactor = StationInteractor(presenter: presenter, provider: provider)
        let viewController = StationViewController(interactor: interactor)

        presenter.viewController = viewController
        self.moduleInput = interactor
        interactor.moduleOutput = self.moduleOutput

        return viewController
    }
}
