//
//  ArticlesResponse.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

class ArticlesResponse: BaseResponse {
    var totalResults: Int?
    var articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults, articles
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try? container.decode(Int.self, forKey: .totalResults)
        articles = try? container.decode([Article].self, forKey: .articles)
    }
}
