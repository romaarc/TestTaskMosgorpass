import UIKit

final class MapDetailAssembly: Assembly {
    var viewModel: StationViewModel!
    var moduleInput: MapDetailInputProtocol?

    private weak var moduleOutput: MapDetailOutputProtocol?

    init(output: MapDetailOutputProtocol? = nil) {
        self.moduleOutput = output
    }

    func makeModule(with context: ModuleContext?) -> UIViewController {
        let provider = MapDetailProvider()
        let presenter = MapDetailPresenter()
        let interactor = MapDetailInteractor(presenter: presenter, provider: provider)
        
        let viewController = MapDetailViewController(
            interactor: interactor,
            stationViewModel: viewModel)

        presenter.viewController = viewController
        self.moduleInput = interactor
        interactor.moduleOutput = self.moduleOutput

        return viewController
    }
}
