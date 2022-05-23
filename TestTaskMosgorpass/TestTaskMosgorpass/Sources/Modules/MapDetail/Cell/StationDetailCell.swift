//
//  StationDetailCell.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 23.05.2022.
//

import UIKit
import SnapKit

class StationDetailCell: BaseUICollectionViewCell {
    
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
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)
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
extension StationDetailCell {
    
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
    
    //MARK: - Update with route
    func update(withDetail viewModel: RoutePath) {
        switch viewModel.type {
        case .bus:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
            
            nameLabel.text = viewModel.number
            
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        case .mcd:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
            
            nameLabel.text = viewModel.number
           
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        case .publicTransport:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
            
            nameLabel.text = viewModel.number
            
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        case .subwayHall:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
            
            nameLabel.text = viewModel.number
            
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        case .train:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
            
            nameLabel.text = viewModel.number
            
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        case .tram:
            if !viewModel.timeArrival.isEmpty {
                let timeArrivalStr = viewModel.timeArrival[0]
                typeLabel.text = "\(timeArrivalStr.arrivingForRussian(count: UInt(Int(timeArrivalStr.dropLast(4)) ?? 0)))"
            } else {
                typeLabel.text = "Прибыл"
            }
           
            nameLabel.text = viewModel.number
            
            if let hexStringValue = UInt32(viewModel.color.dropFirst(1), radix: 16) {
                contentView.backgroundColor = UIColor.init(hex6: hexStringValue)
            }
            if let hexStringValue = UInt32(viewModel.fontColor.dropFirst(1), radix: 16) {
                nameLabel.textColor = UIColor.init(hex6: hexStringValue)
                typeLabel.textColor = nameLabel.textColor
            }
        }
    }
}

