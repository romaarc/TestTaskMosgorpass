import UIKit

protocol MapDetailPresenterProtocol {
    func presentStationResult(response: MapDetailLoad.Loading.Response)
}

final class MapDetailPresenter: MapDetailPresenterProtocol {
    weak var viewController: MapDetailViewControllerProtocol?

    func presentStationResult(response: MapDetailLoad.Loading.Response) {
        switch response.result {
        case .success(let result):
            ///Преобразую данные во вьюмодели и делаю дикишинари для секций
            var dictTransortType = [[TypeElement: Int]]()
            var viewModels = [StationDetailViewModel]()
            let transportTypes = Array(Set(result.routePath.map { station -> TypeElement in
                return station.type
            })).sorted()
            
            for type in transportTypes {
                dictTransortType.append([type: result.routePath.filter({ $0.type == type }).count])
            }
            
            viewModels = [result].map { stationDetail in
                StationDetailViewModel(id: stationDetail.id,
                                       name: stationDetail.name,
                                       type: stationDetail.type,
                                       color: stationDetail.color,
                                       routePath: stationDetail.routePath)
            }
            viewController?.displayStationDetail(viewModel: .init(data: (viewModels, dictTransortType)))
        case .failure(_):
            viewController?.displayError(error: .init())
        }
    }
}
