import UIKit

protocol MapDetailPresenterProtocol {
    func presentSomeActionResult(response: MapDetail.SomeAction.Response)
}

final class MapDetailPresenter: MapDetailPresenterProtocol {
    weak var viewController: MapDetailViewControllerProtocol?

    func presentSomeActionResult(response: MapDetail.SomeAction.Response) { }
}