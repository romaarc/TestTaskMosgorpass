import UIKit

protocol StationPresenterProtocol {
    func presentStationsResult(response: StationLoad.Loading.Response)
    func presentDetailStationResult(response: StationDetailFinding.Loading.Response)
}

final class StationPresenter: StationPresenterProtocol {
    weak var viewController: StationViewControllerProtocol?
    
    func presentStationsResult(response: StationLoad.Loading.Response) {
        switch response.result {
        case .success(let result):
            ///Преобразую данные во вьюмодели и делаю дикишинари для секций
            var dictTransortType = [[TypeElement: Int]]()
            var viewModels = [StationViewModel]()
            let transportTypes = Array(Set(result.map { station -> TypeElement in
                return station.type
            })).sorted()
            
            for type in transportTypes {
                dictTransortType.append([type: result.filter({ $0.type == type }).count])
            }
            viewModels = result.map { station in
                StationViewModel(
                    id: station.id,
                    lat: station.lat,
                    lon: station.lon,
                    name: station.name,
                    type: station.type,
                    routeNumber: station.routeNumber,
                    color: station.color,
                    routeName: station.routeName,
                    subwayID: station.subwayID,
                    shareURL: station.shareURL,
                    wifi: station.wifi,
                    usb: station.usb,
                    transportType: station.transportType,
                    transportTypes: station.transportTypes,
                    isFavorite: station.isFavorite,
                    icon: station.icon,
                    mapIcon: station.mapIcon,
                    mapIconSmall: station.mapIconSmall,
                    cityShuttle: station.cityShuttle,
                    electrobus: station.electrobus)
            }
            viewController?.displayStations(viewModel: .init(data: (viewModels, dictTransortType)))
        case .failure(_):
            ///Обработать ошибку
            viewController?.displayError(error: .init())
        }
    }
    
    func presentDetailStationResult(response: StationDetailFinding.Loading.Response) {
        switch response.result {
        case .success(let result):
            viewController?.displayDetailStation(viewModel: .init(data: result[0]))
        case .failure(_):
            ///Обработать ошибку
            break
        }
    }
}
