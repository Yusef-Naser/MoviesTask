//
//  DiscoverVC.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

class DiscoverVC : BaseVC<DiscoverView> {
    
    // init protocol as type of presenter
    private var presenter : ProDiscoverPresetner?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = DiscoverPresenter(view : self ) // implement protocol "ProDiscoverView"
        // call descover API
        presenter?.getDiscoverMovies()
        mainView.setDelegate(delegate: self ) // set delegate and datasource for tableView
        
        // add refresh to tableView
        refreshController = mainView.tableView.addRefreshController()
        refreshController?.addTarget(self , action: #selector(refreshMoveis), for: .valueChanged)
        
    }
    
    @objc private func refreshMoveis () {
        // refresh data and reset stored data in presenter
        presenter?.refreshData()
    }
    
}

extension DiscoverVC : ProDiscoverView {
    
    // call this when data fetched from server
    func fetchMovies() {
        mainView.tableView.reloadData()
    }
    
}

extension DiscoverVC : UITableViewDelegate , UITableViewDataSource {
    
    // user this function to handle pagination from server
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.callPaginate(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.getIdentifier() , for: indexPath) as! MovieCell
        // configuration protocol in the cell to send data
        presenter?.configurationMovies(cell: cell , index: indexPath.row )
        return cell
    }
    
}
