import SnapKit
import UIKit

extension StationView {
    struct Appearance {
        let backgroundColor = UIColor.white
        let collectionViewBackgroundColor = UIColor.clear
    }
}

final class StationView: UIView, StationViewProtocol {
    let appearance: Appearance
    
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
        collectionView.register(StationHeaderlView.self)
        collectionView.register(StationCell.self)

        return collectionView
    }()

    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
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
                collectionView.setEmptyMessage(message: StationConstants.Strings.emptyMessage)
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

extension StationView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = appearance.backgroundColor
        collectionView.backgroundColor = appearance.collectionViewBackgroundColor
    }

    func addSubviews() {
        addSubview(collectionView)
        collectionView.addSubview(activityIndicator)
    }

    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
