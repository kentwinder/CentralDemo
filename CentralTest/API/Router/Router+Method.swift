//
//  Router+Method.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

extension Router {
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
