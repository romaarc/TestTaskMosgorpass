//
//  StationViewProtocol.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 19.05.2022.
//

import UIKit

protocol StationViewProtocol: AnyObject {
    func updateCollectionViewData(
        delegate: UICollectionViewDelegate,
        dataSource: UICollectionViewDataSource,
        isEmptyCollectionData: Bool)
}
