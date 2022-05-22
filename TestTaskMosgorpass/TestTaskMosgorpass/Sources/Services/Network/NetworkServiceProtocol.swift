//
//  NetworkServiceProtocol.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation
import PromiseKit

///protocol NetworkServiceProtocol, чтобы использовать в AppDependency и в дальнейшем реализовать методы
protocol NetworkServiceProtocol {
    func fetch() -> Promise<Response<Station>>
    func fetchById(withID id: String) -> Promise<StationDetail>
}
