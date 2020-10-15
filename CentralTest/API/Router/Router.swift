//
//  Router.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

protocol BaseRouter {
    var apiUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var payload: Encodable? { get }
    
    func asURLRequest() throws -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum Router: BaseRouter {
    case articlesList(keyword: String, page: Int)
}

extension Router {
    var headers: [String: String]? {
        return nil
    }
    
    var apiUrl: String {
        return "http://newsapi.org/v2" + path
    }
}
