//
//  SearchMoviesPresenter.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//VC

import Foundation

protocol ProSearchMoviesView : StatusApi {
    func fetchMovies()
}

protocol ProSearchMoviesPresetner {

    func getSearchMovies (text : String)
    func callPaginate (index : Int )
    func getMoviesCount () -> Int
    func configurationMovies(cell : ConfigurationCell , index : Int )
    func refreshData()
    
}


class SearchMoviesPresenter : ProSearchMoviesPresetner {

    weak var view : ProSearchMoviesView?
    var interactor = SearchMoviesInteractor()
    var pageResults = PaginationClass<ModelResult>()
    private var refresh = false
    private var textSearch = ""
    
    // handle of this first search or not
    private var firstTimeSearch = true
    
    init(view : ProSearchMoviesView ) {
        self.view = view
    }
    
    
    // check if first search then call search api
    // else --> search text is new text then reset data and search with new text
    // to get new data
    // else --> call search api and handle pagination
    func getSearchMovies(text: String) {
        guard !text.isEmpty else {
            self.view?.onError("please write your search text")
            self.view?.hideLoading()
            return
        }
        if firstTimeSearch {
            firstTimeSearch = false
            textSearch = text
            searchFromAPI(text: textSearch)
            return
        }
        if textSearch != text  {
            pageResults.resetData()
            textSearch = text
        }
        searchFromAPI(text: textSearch)
        
    }
    
    func searchFromAPI(text : String) {
        if !(pageResults.beforeCallService()){
            return
        }
               
        if refresh{
            refresh = false
        }else {
            self.view?.showLoading()
        }
        interactor.getSearchMovies(text: text , page: pageResults.currentPage) { [weak self] (data , error , statusCode) in
            DispatchQueue.main.async { [weak self] in
                self?.view?.hideLoading()
            }
            guard let data = data else {
                self?.view?.onFailure(error?.localizedDescription ?? "Error happen")
                return
            }
            
            if let r = data.results , statusCode == 200 {
                SharedData.instance.setRecent(text: text)
                self?.pageResults.setDataPagination(listData: r , currentPage: data.page ?? 1, totalPages: data.totalPages ?? 1)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.fetchMovies()
                }
                
            }else {
                self?.view?.onFailure(error?.localizedDescription ?? "Error happen")
            }
        }
    }
    
    //call this function in WillDispay in tableView
    func callPaginate(index: Int) {
        if pageResults.allowPagination(index: index) {
            getSearchMovies(text: textSearch)
        }
    }
    
    func getMoviesCount() -> Int {
        return pageResults.listData.count
    }
    
    // send data to cell by conform protocol "ConfigurationCell"
    func configurationMovies(cell: ConfigurationCell, index: Int) {
        if index >= pageResults.listData.count {
            return
        }
        let item = pageResults.listData[index]
        cell.setName(name: item.originalTitle ?? "" )
        cell.setOverview(overview: item.overview ?? "" )
        cell.setReleaseDate(date: item.releaseDate ?? "" )
        cell.setThumbnail(thum: item.posterPath ?? "")
    }
    
    
    // reset data when user swip to refresh
    func refreshData() {
        pageResults.resetData()
        refresh = true
        getSearchMovies(text: textSearch)
    }
    
}
