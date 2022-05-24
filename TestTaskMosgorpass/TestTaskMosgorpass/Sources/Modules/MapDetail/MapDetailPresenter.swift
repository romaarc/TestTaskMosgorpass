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
            var routeSortedPath = [RoutePath]()
            let transportTypes = Array(Set(result.routePath.map { station -> TypeElement in
                return station.type
            })).sorted()
            
            for type in transportTypes {
                dictTransortType.append([type: result.routePath.filter({ $0.type == type }).count])
            }
            
            routeSortedPath = result.routePath.sorted(by: { $0.type != .train ? Int($0.number) ?? 0 < Int($1.number) ?? 0 : $0.timeArrivalSecond[0] < $1.timeArrivalSecond[0] } )
            
            viewModels = [result].map { stationDetail in
                StationDetailViewModel(id: stationDetail.id,
                                       name: stationDetail.name,
                                       type: stationDetail.type,
                                       color: stationDetail.color,
                                       routePath: routeSortedPath)
            }
            viewController?.displayStationDetail(viewModel: .init(data: (viewModels, dictTransortType)))
        case .failure(_):
            viewController?.displayError(error: .init())
        }
    }
}
