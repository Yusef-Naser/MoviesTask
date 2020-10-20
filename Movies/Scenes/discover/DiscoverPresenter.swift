//
//  DiscoverPresenter.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//VC

import Foundation

// notify viewController
protocol ProDiscoverView : StatusApi {
    func fetchMovies()
}

// user this protocol as type of presenter
protocol ProDiscoverPresetner {
    
    func getDiscoverMovies ()
    func callPaginate (index : Int )
    func getMoviesCount () -> Int
    func configurationMovies(cell : ConfigurationCell , index : Int )
    func refreshData()
    
}


class DiscoverPresenter : ProDiscoverPresetner {
    
    weak var view : ProDiscoverView?
    var interactor = DiscoverInteractor()
    
    // handle pagination
    var pageResults = PaginationClass<ModelResult>()
    
    // use this variable to detect if user swipe to refresh or not
    private var refresh = false
    
    init(view : ProDiscoverView ) {
        self.view = view
    }
    
    func getDiscoverMovies() {
        if !(pageResults.beforeCallService()){
            return
        }
               
        if refresh{
            refresh = false
        }else {
            self.view?.showLoading()
        }
        interactor.getDiscoverMovies(page: pageResults.currentPage ) { [weak self] (data , error , statusCode) in
            DispatchQueue.main.async { [weak self] in
                self?.view?.hideLoading()
            }
            
            guard let data = data else {
                self?.view?.onFailure(error?.localizedDescription ?? "Error happen")
                return
            }
            
            if let r = data.results , statusCode == 200 {
                self?.pageResults.setDataPagination(listData: r , currentPage: data.page ?? 1, totalPages: data.totalPages ?? 1)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.fetchMovies()
                }
                
            }else {
                self?.view?.onFailure(error?.localizedDescription ?? "Error happen")
            }
            
        }
    }
    
    // call this function in WillDisplay in tableview
    func callPaginate(index : Int ) {
        if pageResults.allowPagination(index: index) {
            getDiscoverMovies()
        }
    }
    
    func getMoviesCount() -> Int {
        return pageResults.listData.count
    }
    
    // send  data to cell by conform "ConfigurationCell" to cell
    func configurationMovies(cell : ConfigurationCell , index : Int ) {
        if index >= pageResults.listData.count {
            return
        }
        let item = pageResults.listData[index]
        cell.setName(name: item.originalTitle ?? "" )
        cell.setOverview(overview: item.overview ?? "" )
        cell.setReleaseDate(date: item.releaseDate ?? "" )
        cell.setThumbnail(thum: item.posterPath ?? "")
    }
    
    // when user swip to refresh and reset data
    func refreshData() {
        pageResults.resetData()
        refresh = true
        getDiscoverMovies()
    }
    
}
