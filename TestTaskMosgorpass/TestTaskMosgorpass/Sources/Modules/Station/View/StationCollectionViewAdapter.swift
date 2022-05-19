//
//  StationCollectionViewAdapter.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 19.05.2022.
//

import Foundation
import UIKit

protocol StationCollectionViewAdapterDelegate: AnyObject {
    func stationCollectionViewAdapter(
        _ adapter: StationCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
}

final class StationCollectionViewAdapter: NSObject {
    weak var delegate: StationCollectionViewAdapterDelegate?
    
    var components: [StationViewModel]
    var boundsWidth: CGFloat = 0
    
    init(components: [StationViewModel] = []) {
        self.components = components
        super.init()
    }
}

// MARK: - StationCollectionViewAdapter: UICollectionViewDataSource -
extension StationCollectionViewAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: StationCell.self, for: indexPath)
        let component = components[indexPath.row]
        cell.update(with: component)
        return cell
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

extension StationCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
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
