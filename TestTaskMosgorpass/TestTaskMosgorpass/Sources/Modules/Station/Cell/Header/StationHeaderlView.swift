//
//  StationHeaderlView.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 20.05.2022.
//

import UIKit
import SnapKit

class StationHeaderlView: BaseUICollectionReusableView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.38, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    override func setupView() {
        addSubview(label)
        makeConstraints()
    }
    
    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.bottom.height.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func update(with viewModel: TypeElement) {
        label.text = viewModel.titles
    }
}
