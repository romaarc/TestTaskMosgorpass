import UIKit
import YandexMapsMobile
import CoreLocation
import Reachability

protocol MapDetailViewControllerProtocol: AnyObject {
    func displayStationDetail(viewModel: MapDetailLoad.Loading.ViewModel)
    func displayError(error: MapDetailLoad.Loading.onError)
}

final class MapDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    private let interactor: MapDetailInteractorProtocol
    private let stationViewModel: StationViewModel
    private let reachability = try! Reachability()
    
    private var locationManager: CLLocationManager!
    private var collectionViewAdapter = StationDetailCollectionViewAdapter()
    
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
        collectionViewAdapter.delegate = self
        setupNavigationBar()
        setupTargetZoomButtons()
        setupLocationManager()
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged(note:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            try reachability.startNotifier()
        } catch{
            print("Could not start reachability notifier")
        }
        
        if navigationController?.navigationBar.isHidden == false {
            navigationController?.navigationBar.isHidden = true
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - MapDetailViewController: MapDetailViewControllerProtocol -
extension MapDetailViewController: MapDetailViewControllerProtocol {
    func displayStationDetail(viewModel: MapDetailLoad.Loading.ViewModel) {
        guard let stationDetailView = stationDetailView else { return }
        collectionViewAdapter.components = viewModel.data.0
        collectionViewAdapter.filters = viewModel.data.1
        collectionViewAdapter.boundsWidth = stationDetailView.bounds.width
        DispatchQueue.main.async {
            stationDetailView.header.update(someText: viewModel.data.0[0].name)
            stationDetailView.updateCollectionViewData(
                delegate: self.collectionViewAdapter,
                dataSource: self.collectionViewAdapter,
                isEmptyCollectionData: false)
        }
    }
    
    func displayError(error: MapDetailLoad.Loading.onError) {
        guard let stationDetailView = stationDetailView else { return }
        stationDetailView.activityIndicator.startAnimating()
        DispatchQueue.main.async {
            stationDetailView.updateCollectionViewData(
                delegate: self.collectionViewAdapter,
                dataSource: self.collectionViewAdapter,
                isEmptyCollectionData: true)
        }
    }
}

// MARK: - MapDetailViewController
extension MapDetailViewController {
    private func setupTargetZoomButtons() {
        stationDetailView?.zoomInButton.addTarget(self, action: #selector(onTapZoomInButton), for: .touchUpInside)
        stationDetailView?.zoomOutButton.addTarget(self, action: #selector(onTapZoomOutButton), for: .touchUpInside)
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func configureMap() {
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
    
    private func fetchStation() {
        stationDetailView?.activityIndicator.startAnimating()
        interactor.doStationUpdate(request: .init(data: stationViewModel))
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
    
    @objc
    func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
            if collectionViewAdapter.components.isEmpty {
                fetchStation()
            }
        case .unavailable:
            if collectionViewAdapter.components.isEmpty {
                displayError(error: .init())
            }
        case .none:
            break
        }
    }
}

// MARK: - MapDetailViewController: YMKLayersGeoObjectTapListener, YMKMapInputListener -
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

//MARK - MapDetailViewController: StationDetailCollectionViewAdapterDelegate -
extension MapDetailViewController: StationDetailCollectionViewAdapterDelegate {
    func stationDetailCollectionViewAdapter(_ adapter: StationDetailCollectionViewAdapter, didSelectComponentAt indexPath: IndexPath) {}
}
