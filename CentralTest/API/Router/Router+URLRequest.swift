//
//  Router+URLRequest.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

extension Router {
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: apiUrl)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        setHttpHeaders(urlRequest: &urlRequest, headers: headers)
        if method != .get {
            guard let payload = payload, let data = payload.toJSONData() else {
                return urlRequest
            }
            urlRequest.httpBody = data
        }
        return urlRequest
    }
    
    func setHttpHeaders(urlRequest: inout URLRequest, headers: [String: String]?) {
        addDefaultHttpHeader(urlRequest: &urlRequest)
        if let headers = headers {
            for each in headers.keys {
                urlRequest.setValue(headers[each], forHTTPHeaderField: each)
            }
        }
    }
    
    func addDefaultHttpHeader(urlRequest: inout URLRequest) {
        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}
