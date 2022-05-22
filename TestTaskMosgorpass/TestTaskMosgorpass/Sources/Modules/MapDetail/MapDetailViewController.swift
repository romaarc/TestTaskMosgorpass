import UIKit
import YandexMapsMobile
import CoreLocation

protocol MapDetailViewControllerProtocol: AnyObject {
    func displaySomeActionResult(viewModel: MapDetail.SomeAction.ViewModel)
}

final class MapDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    private let interactor: MapDetailInteractorProtocol
    private let stationViewModel: StationViewModel
    
    private var locationManager: CLLocationManager!
    
    var stationDetailView: MapDetailView? { self.view as? MapDetailView }
    
    private var target: YMKPoint {
        return YMKPoint(latitude: stationViewModel.lat, longitude: stationViewModel.lon)
    }
    
    private var map: YMKMap {
        return (stationDetailView?.mapView.mapWindow.map)!
    }

    init(
        interactor: MapDetailInteractorProtocol,
        stationViewModel: StationViewModel
    ) {
        self.interactor = interactor
        self.stationViewModel = stationViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = MapDetailView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTargetZoomButtons()
        setupLocationManager()
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.navigationBar.isHidden == false {
            navigationController?.navigationBar.isHidden = true
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTargetZoomButtons() {
        stationDetailView?.zoomInButton.addTarget(self, action: #selector(onTapZoomInButton), for: .touchUpInside)
        stationDetailView?.zoomOutButton.addTarget(self, action: #selector(onTapZoomOutButton), for: .touchUpInside)
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureMap() {
        DispatchQueue.main.async {
            self.map.move(
                with: YMKCameraPosition.init(target: self.target, zoom: 17, azimuth: 0, tilt: 0))
            
            self.map.addTapListener(with: self)
            self.map.addInputListener(with: self)
            
            let mapObjects = self.map.mapObjects
            let placemark = mapObjects.addPlacemark(with: self.target)
            placemark.setIconWith(UIImage(named: "circle")!)
        }
    }
    
    @objc
    func onTapZoomInButton() {
        let zoomStep: Float = 1
        DispatchQueue.main.async {
            self.map.move(
                with: YMKCameraPosition(
                    target: self.target,
                    zoom: self.map.cameraPosition.zoom + zoomStep,
                    azimuth: 0,
                    tilt: 0),
                animationType: YMKAnimation(type: .smooth, duration: 0.3),
                cameraCallback: nil)
        }
    }
    
    @objc
    func onTapZoomOutButton() {
        let zoomStep: Float = -1
        DispatchQueue.main.async {
            self.map.move(
                with: YMKCameraPosition(
                    target: self.target,
                    zoom: self.map.cameraPosition.zoom + zoomStep,
                    azimuth: 0,
                    tilt: 0),
                animationType: YMKAnimation(type: .smooth, duration: 0.3),
                cameraCallback: nil)
        }
    }
}

extension MapDetailViewController: MapDetailViewControllerProtocol {
    func displaySomeActionResult(viewModel: MapDetail.SomeAction.ViewModel) { }
}

extension MapDetailViewController: YMKLayersGeoObjectTapListener, YMKMapInputListener {
    func onObjectTap(with: YMKGeoObjectTapEvent) -> Bool {
        let event = with
        let metadata = event.geoObject.metadataContainer.getItemOf(YMKGeoObjectSelectionMetadata.self)
        if let selectionMetadata = metadata as? YMKGeoObjectSelectionMetadata {
            map.selectGeoObject(withObjectId: selectionMetadata.id, layerId: selectionMetadata.layerId)
            return true
        }
        return false
    }
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        self.map.deselectGeoObject()
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {}
    
    func onObjectAdded(with view: YMKUserLocationView) {}
}
