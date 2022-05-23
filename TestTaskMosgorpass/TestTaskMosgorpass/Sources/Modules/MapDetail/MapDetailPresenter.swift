import UIKit

protocol MapDetailPresenterProtocol {
    func presentStationResult(response: MapDetailLoad.Loading.Response)
}

final class MapDetailPresenter: MapDetailPresenterProtocol {
    weak var viewController: MapDetailViewControllerProtocol?

    func presentStationResult(response: MapDetailLoad.Loading.Response) {
        switch response.result {
        case .success(let result):
            var viewModel: StationDetailViewModel!
            viewModel = [result].map { stationDetail in
                StationDetailViewModel(id: stationDetail.id,
                                       name: stationDetail.name,
                                       type: stationDetail.type,
                                       color: stationDetail.color,
                                       routePath: stationDetail.routePath)
            }[0]
            viewController?.displayStationDetail(viewModel: .init(data: viewModel))
        case .failure(_):
            viewController?.displayError(error: .init())
        }
    }
}
