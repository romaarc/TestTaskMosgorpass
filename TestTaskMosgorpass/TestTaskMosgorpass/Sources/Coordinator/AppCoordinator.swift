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
    
    init(
        window: UIWindow,
        appDependency: AppDependency
    ) {
        self.window = window
        self.appDependency = appDependency
    }
    
    func start() {
        ///режим интерфейса всегда белый
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        window.rootViewController = setupStationVC()
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    ///Функция собирает модуль VIP, добавляя context в котором наш контейнер с сервисами и возвращает UIViewController
    func setupStationVC() -> UIViewController {
        let contex = ModuleContext(moduleDependencies: appDependency)
        let container = StationAssembly()
        return container.makeModule(with: contex)
    }
}
