import UIKit

protocol StationPresenterProtocol {
    func presentSomeActionResult(response: StationLoad.SomeAction.Response)
}

final class StationPresenter: StationPresenterProtocol {
    weak var viewController: StationViewControllerProtocol?

    func presentSomeActionResult(response: StationLoad.SomeAction.Response) { }
}
