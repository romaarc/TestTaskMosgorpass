import UIKit

protocol StationViewControllerProtocol: AnyObject {
    func displayStations(viewModel: StationLoad.Loading.ViewModel)
    func displayError(error: StationLoad.Loading.onError)
}

final class StationViewController: UIViewController {
    private let interactor: StationInteractorProtocol
    private let router: StationRouterInput
    
    var stationView: StationView? { self.view as? StationView }
    
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
        fetchStations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.navigationBar.isHidden == true {
            navigationController?.navigationBar.isHidden = false
        }
    }
}

extension StationViewController: StationViewControllerProtocol {
    func fetchStations() {
        stationView?.activityIndicator.startAnimating()
        interactor.doStationsUpdate(request: .init())
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
    
    func displayError(error: StationLoad.Loading.onError) {
        guard let stationView = stationView else { return }
        stationView.activityIndicator.startAnimating()
        DispatchQueue.main.async {
            stationView.updateCollectionViewData(
                delegate: self.collectionViewAdapter,
                dataSource: self.collectionViewAdapter,
                isEmptyCollectionData: true)
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
