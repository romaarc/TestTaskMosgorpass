//
//  StationCell.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 19.05.2022.
//

import UIKit
import SnapKit

final class StationCell: BaseUICollectionViewCell {
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90

        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        [typeLabel, nameLabel].forEach { contentView.addSubview($0) }
        setupUI()
        cornerRadius = StationConstants.Layout.cornerRadius
        shadowRadius = StationConstants.Layout.shadowRadius
        shadowOpacity = StationConstants.Layout.shadowOpacity
    }
}
    //MARK: - UI
extension StationCell {
    
    private func setupUI() {
        typeLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(43)
        }
    }
    
    //MARK: - Update with ViewModel
    func update(with viewModel: StationViewModel) {
        switch viewModel.type {
        case .bus:
            typeLabel.text = viewModel.electrobus ? "Электробус" : viewModel.type.title
            nameLabel.text = viewModel.name
            nameLabel.textColor = UIColor.black
        case .mcd:
            typeLabel.text = viewModel.type.title
            nameLabel.text = viewModel.name
            nameLabel.textColor = UIColor.black
        case .publicTransport:
            typeLabel.text = viewModel.electrobus ? "Электробус" : viewModel.type.title
            nameLabel.text = viewModel.name
            nameLabel.textColor = UIColor.black
        case .subwayHall:
            typeLabel.text = viewModel.type.title
            nameLabel.text = viewModel.name
            if let color = viewModel.color {
                guard let hexStringValue = UInt32(color.dropFirst(1), radix: 16) else { return }
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
            }
        case .train:
            typeLabel.text = viewModel.type.title
            nameLabel.text = viewModel.name
            nameLabel.textColor = UIColor.black
        case .tram:
            typeLabel.text = viewModel.type.title
            nameLabel.text = viewModel.name
            nameLabel.textColor = UIColor.black
        }
    }
}
