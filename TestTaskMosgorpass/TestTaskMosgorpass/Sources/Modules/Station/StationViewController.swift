import UIKit
import Reachability

protocol StationViewControllerProtocol: AnyObject {
    func displayStations(viewModel: StationLoad.Loading.ViewModel)
    func displayError(error: StationLoad.Loading.OnError)
    func displayDetailStation(viewModel: StationDetailFinding.Loading.ViewModel)
}

final class StationViewController: UIViewController {
    private let interactor: StationInteractorProtocol
    private let router: StationRouterInput
    
    var stationView: StationView? { self.view as? StationView }
    
    private let reachability = try! Reachability()
    
    private var collectionViewAdapter = StationCollectionViewAdapter()
    
    init(
        interactor: StationInteractorProtocol,
        router: StationRouterInput
    ) {
        self.interactor = interactor
        self.router = router
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewAdapter.delegate = self
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
        
        if navigationController?.navigationBar.isHidden == true {
            navigationController?.navigationBar.isHidden = false
            if collectionViewAdapter.components.isEmpty {
                stationView?.activityIndicator.startAnimating()
                interactor.doStationsUpdate(request: .init())
            } else {
                interactor.doDetailStationDelete(request: .init())
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
// MARK: - StationViewController: StationViewControllerProtocol -
extension StationViewController: StationViewControllerProtocol {
    func displayDetailStation(viewModel: StationDetailFinding.Loading.ViewModel) {
        let data = viewModel.data
        let component = StationViewModel(
            id: data.id,
            lat: data.lat,
            lon: data.lon
        )
        router.showDetail(with: component)
    }
    
    func fetchStations() {
        stationView?.activityIndicator.startAnimating()
        interactor.doFindingDetailStation(request: .init())
    }
    
    func displayStations(viewModel: StationLoad.Loading.ViewModel) {
        guard let stationView = stationView else { return }
        collectionViewAdapter.components = viewModel.data.0
        collectionViewAdapter.filters = viewModel.data.1
        collectionViewAdapter.boundsWidth = stationView.bounds.width
        DispatchQueue.main.async {
            stationView.updateCollectionViewData(
                delegate: self.collectionViewAdapter,
                dataSource: self.collectionViewAdapter,
                isEmptyCollectionData: false)
        }
    }
    
    func displayError(error: StationLoad.Loading.OnError) {
        guard let stationView = stationView else { return }
        stationView.activityIndicator.startAnimating()
        DispatchQueue.main.async {
            stationView.updateCollectionViewData(
                delegate: self.collectionViewAdapter,
                dataSource: self.collectionViewAdapter,
                isEmptyCollectionData: true)
        }
    }
    
    @objc
    func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
            if collectionViewAdapter.components.isEmpty {
                fetchStations()
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

// MARK: - StationViewController: StationCollectionViewAdapterDelegate -
extension StationViewController: StationCollectionViewAdapterDelegate {
    func stationCollectionViewAdapter(
        _ adapter: StationCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath) {
            var sectionComponents: [StationViewModel] = []
            let dict: [TypeElement: Int] = adapter.filters[indexPath.section]
            for key in dict.keys {
                sectionComponents = adapter.components.filter { $0.type == key }
            }
            sectionComponents = sectionComponents.sorted { $0.name < $1.name }
            let component = sectionComponents[indexPath.row]
            router.showDetail(with: component)
        }
}
