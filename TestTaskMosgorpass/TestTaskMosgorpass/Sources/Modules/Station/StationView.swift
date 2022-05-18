import SnapKit
import UIKit

extension StationView {
    struct Appearance { }
}

final class StationView: UIView {
    let appearance: Appearance

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
}

extension StationView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = .yellow
    }

    func addSubviews() { }

    func makeConstraints() { }
}
