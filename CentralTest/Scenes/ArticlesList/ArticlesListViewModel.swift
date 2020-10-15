//
//  ArticlesListViewModel.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import RxCocoa
import RxSwift

protocol ArticlesListViewModelInput {
    func searchArticles(with keyword: String)
    func getNextArticlesListPage()
}

protocol ArticlesListViewModelOutput {
    var reloadData: Driver<Void> { get }
    func numberOfArticles() -> Int
    func articleForCellAt(indexPath: IndexPath) -> Article
    var hasMoreData: Bool { get }
}

protocol ArticlesListViewModel: ArticlesListViewModelInput, ArticlesListViewModelOutput {}

open class DefaultArticlesListViewModel: ArticlesListViewModel {
    private let articleManager: ArticleManager
    
    private let _reloadData = PublishSubject<Void>()
    private var articles: [Article] = []
    private var hasMore = false
    private var currentKeyword = ""
    private var currentPage = 1
    
    init(articleManager: ArticleManager) {
        self.articleManager = articleManager
    }
    
    // MARK: - Output
    var reloadData: Driver<Void> {
        return _reloadData.asDriver(onErrorJustReturn: ())
    }
    func numberOfArticles() -> Int {
        return articles.count
    }
    func articleForCellAt(indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    var hasMoreData: Bool { return hasMore }
}

// MARK: - Input
extension DefaultArticlesListViewModel {
    func searchArticles(with keyword: String) {
        currentPage = 1
        currentKeyword = keyword
        hasMore = true
        articles.removeAll()
        getArticles()
    }
    
    func getNextArticlesListPage() {
        guard hasMore else { return }
        
        currentPage += 1
        getArticles()
    }
    
    private func getArticles() {
        articleManager.getArticles(keyword: currentKeyword, page: currentPage, completion: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.articles.append(contentsOf: response.articles ?? [])
                if self.articles.count >= response.totalResults ?? 0 {
                    self.hasMore = false
                }
                self._reloadData.onNext(())
                break
            case .failure(let error):
                debugPrint("Get articles failed with error: ", error.message)
                break
            }
        })
    }
}
