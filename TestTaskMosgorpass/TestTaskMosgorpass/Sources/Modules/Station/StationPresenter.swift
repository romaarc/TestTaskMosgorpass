import UIKit

protocol StationPresenterProtocol {
    func presentStationsResult(response: StationLoad.Loading.Response)
}

final class StationPresenter: StationPresenterProtocol {
    weak var viewController: StationViewControllerProtocol?

    func presentStationsResult(response: StationLoad.Loading.Response) {
        switch response.result {
        case .success(let result):
            ///Преобразую данные во вьюмодели
            var viewModels = [StationViewModel]()
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
            viewController?.displayStations(viewModel: .init(data: viewModels))
        case .failure(_):
            ///Обработать ошибку
            break
        }
    }
}
