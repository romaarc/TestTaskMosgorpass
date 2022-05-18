//
//  NetworkService+Station.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation
import PromiseKit

/// extension NetworkService реализуем метод протокола NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func fetch() -> Promise<Response<Station>> {
        baseRequest(request: URLFactory.getURL())
    }
}
