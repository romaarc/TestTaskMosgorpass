//
//  URLFactory.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 18.05.2022.
//

import Foundation

/// enum URLFactory создает URLRequest
enum URLFactory {
    
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func getURL() -> URLRequest {
        let urlComponents = baseURLComponents
        var request = URLRequest(url: urlComponents.url!.appendingPathComponent(API.TypeOf.stops))
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 3
        return request
    }
    
    static func getDetailURL(withID id: String) -> URLRequest {
        let urlComponents = baseURLComponents
        var request = URLRequest(url: urlComponents.url!.appendingPathComponent(API.TypeOf.stops).appendingPathComponent(id))
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 3
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
