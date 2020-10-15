//
//  ArticleManager.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

protocol ArticleManager {
    func getArticles(keyword: String, page: Int, completion: @escaping (Swift.Result<ArticlesResponse, BaseError>) -> ())
}

class DefaultArticleManager: ArticleManager {
    init() {}
    
    func getArticles(keyword: String, page: Int, completion: @escaping (Swift.Result<ArticlesResponse, BaseError>) -> ()) {
        let router = Router.articlesList(keyword: keyword, page: page)
        return BaseManager.shared.request(withRouter: router, completion: completion)
    }
}
