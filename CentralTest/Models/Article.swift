//
//  Article.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

class ArticleSource: Decodable {
    var id: String?
    var name: String?
}

class Article: Decodable {
    var source: ArticleSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
