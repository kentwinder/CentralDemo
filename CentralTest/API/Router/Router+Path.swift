//
//  Router+Path.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

extension Router {
    var path: String {
        switch self {
        case .articlesList(let keyword, let page):
            return "/everything?q=\(keyword)&page=\(page)&sortBy=publishedAt&apiKey=\(Constants.API_KEY)"
        }
    }
}
