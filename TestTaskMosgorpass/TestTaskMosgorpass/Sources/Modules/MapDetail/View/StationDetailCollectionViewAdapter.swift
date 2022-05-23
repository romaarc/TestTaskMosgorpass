//
//  StationDetailCollectionViewAdapter.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 23.05.2022.
//

import Foundation
import UIKit

protocol StationDetailCollectionViewAdapterDelegate: AnyObject {
    func stationDetailCollectionViewAdapter(
        _ adapter: StationDetailCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
}

final class StationDetailCollectionViewAdapter: NSObject {
    weak var delegate: StationDetailCollectionViewAdapterDelegate?
    
    var components: [StationDetailViewModel]
    var filters: [[TypeElement: Int]]
    var boundsWidth: CGFloat = 0
    
    init(
        components: [StationDetailViewModel] = [],
        filters: [[TypeElement: Int]] = []
    ) {
        self.components = components
        self.filters = filters
        super.init()
    }
}

// MARK: - StationDetailCollectionViewAdapter: UICollectionViewDataSource -
extension StationDetailCollectionViewAdapter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var countComponents = 0
        let dict: [TypeElement: Int] = filters[section]
        for key in dict.keys {
            countComponents = dict[key] ?? 0
        }
        return countComponents
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: StationDetailCell.self, for: indexPath)
        var sectionComponents: [RoutePath] = []
        let dict: [TypeElement: Int] = filters[indexPath.section]
        for key in dict.keys {
            sectionComponents = components[0].routePath.filter({$0.type == key})
        }
        sectionComponents = sectionComponents.sorted { Int($0.number) ?? 0 < Int($1.number) ?? 0 }
        let component = sectionComponents[indexPath.row]
        cell.update(withDetail: component)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueSectionHeaderCell(cellType: StationHeaderView.self, for: indexPath)
        for key in filters[indexPath.section].keys {
            header.update(with: key)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.stationDetailCollectionViewAdapter(
            self,
            didSelectComponentAt: indexPath
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if components.isEmpty { return .zero }
        return CGSize(width: 298, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 1, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                cell.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.7, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

extension StationDetailCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: boundsWidth, spacing: StationConstants.Layout.spacing)
        return CGSize(width: width, height: StationConstants.Layout.heightCardDescription)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = (StationConstants.Layout.itemsInRow * StationConstants.Layout.spacingLeft + (StationConstants.Layout.itemsInRow - 1) * StationConstants.Layout.spacingRight) + StationConstants.Layout.minimumInteritemSpacingForSectionAt - StationConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / StationConstants.Layout.itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: StationConstants.Layout.spacingTop, left: StationConstants.Layout.spacingLeft, bottom: StationConstants.Layout.spacingBottom, right: StationConstants.Layout.spacingRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        StationConstants.Layout.spacingBottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        StationConstants.Layout.minimumInteritemSpacingForSectionAt
    }
}
