import SnapKit
import UIKit
import YandexMapsMobile
import UltraDrawerView

extension MapDetailView {
    struct Appearance {
        let backgroundColor = UIColor.white
        let cornerRadius: CGFloat = 16
        let shadowRadius: CGFloat = 4
        let shadowOpacity: Float = 0.2
        let shadowOffset = CGSize.zero
        let middleInsetFromBottom: CGFloat = 280
    }
}

final class MapDetailView: UIView, StationViewProtocol {
    let appearance: Appearance
    let mapView: YMKMapView!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(StationHeaderView.self)
        collectionView.register(StationDetailCell.self)

        return collectionView
    }()
    
    let zoomInButton: UIButton = {
        let btn = RoundedButton(radius: 10, backgroundColor: Colors.lightGray, textColor: .black)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = Font.sber(ofSize: 40, weight: .regular)
        btn.isEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let zoomOutButton: UIButton = {
        let btn = RoundedButton(radius: 10, backgroundColor: Colors.lightGray, textColor: .black)
        btn.setTitle("-", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = Font.sber(ofSize: 40, weight: .regular)
        btn.isEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var header: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var drawerView: DrawerView = {
        let drawerView = DrawerView(scrollView: self.collectionView, headerView: self.header)
        drawerView.translatesAutoresizingMaskIntoConstraints = false
        drawerView.availableStates = [.top, .middle, .bottom]
        drawerView.setState(.middle, animated: false)

        // More fluctuations
        drawerView.animationParameters = .spring(mass: 1, stiffness: 200, dampingRatio: 0.5)

        // Default UIScrollView like behavior
        drawerView.animationParameters = .spring(.default)
        
        return drawerView
    }()

    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        self.mapView = YMKMapView(frame: frame)
        super.init(frame: frame)

        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Protocol Conforming
    func updateCollectionViewData(
        delegate: UICollectionViewDelegate,
        dataSource: UICollectionViewDataSource,
        isEmptyCollectionData: Bool) {
            if isEmptyCollectionData {
                activityIndicator.stopAnimating()
                collectionView.setEmptyMessage(message: StationConstants.Strings.emptyDetailMessage)
            } else {
                collectionView.restore()
                collectionView.delegate = delegate
                collectionView.dataSource = dataSource
                collectionView.reloadData()
                collectionView.collectionViewLayout.invalidateLayout()
                activityIndicator.stopAnimating()
            }
        }
    
    func invalidateCollectionViewLayout() {
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.invalidateIntrinsicContentSize()
    }
}

extension MapDetailView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = appearance.backgroundColor
        drawerView.containerView.backgroundColor = appearance.backgroundColor
        drawerView.cornerRadius = appearance.cornerRadius
        drawerView.layer.shadowRadius = appearance.shadowRadius
        drawerView.layer.shadowOpacity = appearance.shadowOpacity
        drawerView.layer.shadowOffset = appearance.shadowOffset
        drawerView.middlePosition = .fromBottom(appearance.middleInsetFromBottom)
    }

    func addSubviews() {
        addSubview(mapView)
        mapView.addSubview(zoomInButton)
        mapView.addSubview(zoomOutButton)
        addSubview(drawerView)
        collectionView.addSubview(activityIndicator)
    }

    func makeConstraints() {
        zoomInButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(mapView.bounds.height / 3)
            make.leading.equalToSuperview().offset(mapView.bounds.width - 55)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        
        zoomOutButton.snp.makeConstraints { make in
            make.top.equalTo(zoomInButton.snp.top).offset(55)
            make.leading.equalToSuperview().offset(mapView.bounds.width - 55)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        
        mapView?.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        drawerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
