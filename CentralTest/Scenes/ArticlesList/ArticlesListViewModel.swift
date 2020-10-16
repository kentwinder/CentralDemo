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
    var indexPathsToInsert: Driver<[IndexPath]> { get }
    var reloadData: Driver<Void> { get }
    func numberOfArticles() -> Int
    func articleForCellAt(indexPath: IndexPath) -> Article
    var hasMoreData: Bool { get }
}

protocol ArticlesListViewModel: ArticlesListViewModelInput, ArticlesListViewModelOutput {}

open class DefaultArticlesListViewModel: ArticlesListViewModel {
    private let articleManager: ArticleManager
    
    private var indexPathsToInsertRelay = BehaviorRelay<[IndexPath]>(value: [])
    private let _reloadData = PublishSubject<Void>()
    private var articles: [Article] = []
    private var hasMore = false
    private var currentKeyword = ""
    private var currentPage = 1
    private var gettingData = false
    
    init(articleManager: ArticleManager) {
        self.articleManager = articleManager
    }
    
    // MARK: - Output
    var indexPathsToInsert: Driver<[IndexPath]> {
        return indexPathsToInsertRelay.asDriver()
    }
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
        guard !keyword.isEmpty else { return }
        
        currentPage = 1
        currentKeyword = keyword
        hasMore = true
        articles.removeAll()
        _reloadData.onNext(()) // remove all current rows in view
        getArticles()
    }
    
    func getNextArticlesListPage() {
        guard hasMore else { return }
        
        currentPage += 1
        getArticles()
    }
    
    private func getArticles() {
        guard !gettingData else { return }
        
        gettingData = true
        articleManager.getArticles(keyword: currentKeyword, page: currentPage, completion: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let _articles = response.articles ?? []
                if _articles.count > 0 {
                    var indexPaths: [IndexPath] = []
                    for article in _articles {
                        indexPaths.append(IndexPath(row: self.articles.count, section: 0))
                        self.articles.append(article)
                    }
                    self.indexPathsToInsertRelay.accept(indexPaths)
                }
                
                if self.articles.count >= response.totalResults ?? 0 {
                    self.hasMore = false
                }
                break
            case .failure(let error):
                debugPrint("Get articles failed with error: ", error.message)
                break
            }
            
            self.gettingData = false
        })
    }
}
