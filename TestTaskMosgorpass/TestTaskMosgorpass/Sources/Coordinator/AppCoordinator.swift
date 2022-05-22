//
//  AppCoordinator.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation
import UIKit

///Создаю класс AppCoordinator который будет стартовать модуль.
///Класс содержит в себе window, AppDependency - зависимость контейнер с сервисами, для передачи в модули VIP
final class AppCoordinator {
    
    private let window: UIWindow
    private let appDependency: AppDependency
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    
    init(
        window: UIWindow,
        appDependency: AppDependency
    ) {
        self.window = window
        self.appDependency = appDependency
        navigationControllers = AppCoordinator.makeNavigationControllers()
    }
    
    func start() {        
        ///режим интерфейса всегда белый
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        setupStationVC()
        
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        
        window.rootViewController = navigationControllers[0]
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    
    ///Функция собирает модуль VIP, добавляя context в котором наш контейнер с сервисами, ложит VC в NC
    func setupStationVC() {
        guard let navController = self.navigationControllers[.stations] else {
            fatalError("something wrong with appCoordinator")
        }
        let contex = ModuleContext(moduleDependencies: appDependency)
        let container = StationAssembly()
        let stationVC = container.makeModule(with: contex)
        stationVC.navigationItem.title = Localize.stations
        navController.setViewControllers([stationVC], animated: true)
        setupAppearanceNavigationBar(with: navController)
    }
    
    ///Функция собирает NC, через enum NavigationControllersType
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        NavigationControllersType.allCases.forEach { navigationControllerKey in
            let navigationController = UINavigationController()
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.sizeToFit()
            result[navigationControllerKey] = navigationController
        }
        return result
    }
    
    ///Функция делает Appearance NavBar
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Colors.lightGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                       .font : Font.sber(ofSize: Font.Size.twenty, weight: .bold)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font : Font.sber(ofSize: Font.Size.thirdyFour, weight: .bold),
                                                            .paragraphStyle: paragraphStyle,
                                                            .kern: 0.41]
        UINavigationBar.appearance().tintColor = Colors.purple
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
    }
}

///Enum NavigationControllersType для сборки NC
fileprivate enum NavigationControllersType: Int, CaseIterable {
    case stations
    var title: String {
        switch self {
        case .stations:
            return Localize.stations
        }
    }
}
