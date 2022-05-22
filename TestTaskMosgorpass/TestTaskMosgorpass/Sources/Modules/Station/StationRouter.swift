//
//  StationRouter.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 21.05.2022.
//

import Foundation

protocol StationRouterInput: AnyObject {
    func showDetail(with viewModel: StationViewModel)
}

final class StationRouter: BaseRouter {}

extension StationRouter: StationRouterInput {
    func showDetail(with viewModel: StationViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = ModuleContext(moduleDependencies: moduleDependencies)
        let container = MapDetailAssembly()
        container.viewModel = viewModel
        let detailVC = container.makeModule(with: context)
        navigationController?.pushViewController(detailVC, animated: false)
    }
}
