//
//  SearchMoviesVC.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

class SearchMoviesVC : BaseVC<SearchMoviesView> {
    
    // init protocol as type of presenter
    private var presenter : ProSearchMoviesPresetner?
    
    // user this call to delegate history tableView
    let delegateSearch = DelegateSearchHistory()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = SearchMoviesPresenter(view : self )
        mainView.setDelegate(delegate: self ) // implement delegate and datasource for tableView
        mainView.tableViewHistory.delegate = delegateSearch
        mainView.tableViewHistory.dataSource = delegateSearch
        
        // add swip to refresh to tableView
        refreshController = mainView.tableView.addRefreshController()
        refreshController?.addTarget(self , action: #selector( actionRefreshData ), for: .valueChanged)
        
        // handle history text and search with selected text and hide historyView
        delegateSearch.compltionSearchHistory = { [weak self] text in
            self?.presenter?.getSearchMovies(text: text )
            self?.mainView.endEditing(true)
            self?.mainView.hideRecentView()
            self?.mainView.searchBar.text = text
        }
        
    }
    
    // rest data in presenter and call new data
    @objc private func actionRefreshData () {
        presenter?.refreshData()
    }
    
}

// notify viewController when data fetched from server
extension SearchMoviesVC : ProSearchMoviesView {
    func fetchMovies() {
        mainView.tableView.reloadData()
    }
}

extension SearchMoviesVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.callPaginate(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getMoviesCount() ?? 0
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.getIdentifier() , for: indexPath) as! MovieCell
        presenter?.configurationMovies(cell: cell , index: indexPath.row )
        return cell
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print("df")
    }
       
    
}

// handle action of search bar
extension SearchMoviesVC : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.mainView.showRecentView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.mainView.endEditing(true)
        self.mainView.hideRecentView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.getSearchMovies(text: searchBar.text ?? "")
        self.mainView.endEditing(true)
        self.mainView.hideRecentView()
    }
    
}
