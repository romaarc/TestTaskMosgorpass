import UIKit

protocol StationViewControllerProtocol: AnyObject {
    func displaySomeActionResult(viewModel: StationLoad.SomeAction.ViewModel)
}

final class StationViewController: UIViewController {
    private let interactor: StationInteractorProtocol

    init(interactor: StationInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = StationView(frame: UIScreen.main.bounds)
        self.view = view
    }
}

extension StationViewController: StationViewControllerProtocol {
    func displaySomeActionResult(viewModel: StationLoad.SomeAction.ViewModel) { }
}
