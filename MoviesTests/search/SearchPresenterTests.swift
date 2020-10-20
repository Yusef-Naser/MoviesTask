//
//  SearchPresenterTests.swift
//  MoviesTests
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import XCTest
@testable import Movies

class SearchPresenterTests : XCTestCase {
    
    var sut : SearchMoviesPresenter!
    
    static var callPagination = 1
    
    static var originalTitle : String? = ""
    static var overview : String? = ""
    static var releaseDate : String? = ""
    static var posterPath : String? = ""
    
    override func setUp() {
        sut = SearchMoviesPresenter(view: self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getDiscover () {
        sut.interactor = MockInteractor()
        sut.getSearchMovies(text: "Mu")
        XCTAssertEqual(sut.pageResults.listData.count , 3 )
        XCTAssertEqual(sut.getMoviesCount() , 3 )
    }
    
    func test_configurationMovies() {
        sut.interactor = MockInteractor()
        sut.pageResults.setDataPagination(listData: MockData.results , currentPage: 2 , totalPages: 5)
        sut.configurationMovies(cell: MockCell(), index: 0)
        XCTAssertEqual(SearchPresenterTests.posterPath, MockData.results[0].posterPath)
        XCTAssertEqual(SearchPresenterTests.releaseDate, MockData.results[0].releaseDate)
        XCTAssertEqual(SearchPresenterTests.overview, MockData.results[0].overview)
        XCTAssertEqual(SearchPresenterTests.originalTitle, MockData.results[0].originalTitle)
    }
    
    
}
extension SearchPresenterTests : ProSearchMoviesView {
    func showMessage(_ message: String) {
        
    }
    
    func onError(_ message: String) {
        
    }
    
    func onFailure(_ message: String) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func fetchMovies() {
        
    }
}

extension SearchPresenterTests {
    
    class MockInteractor : SearchMoviesInteractor {
        override func getSearchMovies(text: String, page: Int, compltion: @escaping CompletionHandler<ModelDiscover>) {
            SearchPresenterTests.callPagination = page
            compltion( MockData.discover , nil , 200)
        }
    }
    
}

extension SearchPresenterTests {
    
    class MockCell : ConfigurationCell {
        
        func setThumbnail(thum: String) {
            SearchPresenterTests.posterPath = thum
        }
        
        func setName(name: String) {
            SearchPresenterTests.originalTitle = name
        }
        
        func setReleaseDate(date: String) {
            SearchPresenterTests.releaseDate = date
        }
        
        func setOverview(overview: String) {
            SearchPresenterTests.overview = overview
        }
    }
}
 
