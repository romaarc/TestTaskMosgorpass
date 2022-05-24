import UIKit

final class MapDetailAssembly: Assembly {
    var viewModel: StationViewModel!
    var moduleInput: MapDetailInputProtocol?

    private weak var moduleOutput: MapDetailOutputProtocol?

    init(output: MapDetailOutputProtocol? = nil) {
        self.moduleOutput = output
    }

    func makeModule(with context: ModuleContext?) -> UIViewController {
        guard let context = context else { return UIViewController() }
        
        let provider = MapDetailProvider(
            mosgorpassNetworkService: context.moduleDependencies.mosgorpassNetworkService,
            stationDetailRealmService: context.moduleDependencies.stationDetailRealmService
        )
        
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
