//
//  ArticlesListViewController.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import UIKit
import RxSwift

class ArticlesListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticlesListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    func setupViews() {
        navigationController?.title = "News"
        
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }
    
    func setupViewModel() {
        viewModel = DefaultArticlesListViewModel(articleManager: DefaultArticleManager())
        viewModel.reloadData.drive(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension ArticlesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        viewModel.searchArticles(with: searchBar.text ?? "")
    }
}

extension ArticlesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingCell(for: indexPath) {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as! ArticleTableViewCell
        cell.article = viewModel.articleForCellAt(indexPath: indexPath)
        return cell
    }
}

extension ArticlesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = viewModel.articleForCellAt(indexPath: indexPath)
        showDetails(forArticle: article)
    }
    
    private func showDetails(forArticle article: Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ArticleDetailsViewController.identifier) as! ArticleDetailsViewController
        viewController.article = article
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ArticlesListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getNextArticlesListPage()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return viewModel.hasMoreData && indexPath.row >= viewModel.numberOfArticles() - 1
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
