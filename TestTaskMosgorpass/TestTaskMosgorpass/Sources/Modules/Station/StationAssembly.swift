import UIKit

final class StationAssembly: Assembly {
    var moduleInput: StationInputProtocol?
    
    private weak var moduleOutput: StationOutputProtocol?
    
    init(output: StationOutputProtocol? = nil) {
        self.moduleOutput = output
    }
    
    func makeModule(with context: ModuleContext?) -> UIViewController {
        guard let context = context else { return UIViewController() }
        let provider = StationProvider(
            mosgorpassNetworkService: context.moduleDependencies.mosgorpassNetworkService
        )
        let presenter = StationPresenter()
        let interactor = StationInteractor(presenter: presenter, provider: provider)
        let viewController = StationViewController(interactor: interactor)
        
        presenter.viewController = viewController
        self.moduleInput = interactor
        interactor.moduleOutput = self.moduleOutput
        
        return viewController
    }
}
