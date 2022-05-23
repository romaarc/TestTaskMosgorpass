import SnapKit
import UIKit
import YandexMapsMobile
import UltraDrawerView

extension MapDetailView {
    struct Appearance {
        let backgroundColor = UIColor.white
    }
}

final class MapDetailView: UIView {
    let appearance: Appearance
    let mapView: YMKMapView!
    
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
}

extension MapDetailView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = appearance.backgroundColor
    }

    func addSubviews() {
        addSubview(mapView)
        mapView.addSubview(zoomInButton)
        mapView.addSubview(zoomOutButton)
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
    }
}
