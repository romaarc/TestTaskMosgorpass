import UIKit

final class StationAssembly: Assembly {
    var moduleInput: StationInputProtocol?
    
    private weak var moduleOutput: StationOutputProtocol?
    
    init(output: StationOutputProtocol? = nil) {
        self.moduleOutput = output
    }
    
    func makeModule(with context: ModuleContext?) -> UIViewController {
        guard let context = context else { return UIViewController() }
        let router = StationRouter()
        
        let provider = StationProvider(
            mosgorpassNetworkService: context.moduleDependencies.mosgorpassNetworkService,
            stationDetailRealmService: context.moduleDependencies.stationDetailRealmService
        )
        
        let presenter = StationPresenter()
        let interactor = StationInteractor(presenter: presenter, provider: provider)
        
        let viewController = StationViewController(
            interactor: interactor,
            router: router
        )
        
        router.viewControllerProvider = { [weak viewController] in
            viewController
        }
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        router.moduleDependencies = context.moduleDependencies
        
        presenter.viewController = viewController
        self.moduleInput = interactor
        interactor.moduleOutput = self.moduleOutput
        
        return viewController
    }
}
