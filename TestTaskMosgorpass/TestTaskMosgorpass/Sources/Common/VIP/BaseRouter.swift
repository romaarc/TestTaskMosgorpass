//
//  BaseRouter.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 21.05.2022.
//

import UIKit

class BaseRouter {
    var moduleDependencies: ModuleDependencies?
    
    var navigationControllerProvider: (() -> UINavigationController?)?
    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }
    
    var viewControllerProvider: (() -> UIViewController?)?
    var viewController: UIViewController? {
        self.viewControllerProvider?()
    }
}
