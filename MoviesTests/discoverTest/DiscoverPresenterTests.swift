//
//  DiscoverPresenterTests.swift
//  MoviesTests
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import XCTest
@testable import Movies

class DiscoverPresenterTests : XCTestCase {
    
    var sut : DiscoverPresenter!
    
    static var callPagination = 1
    
    static var originalTitle : String? = ""
    static var overview : String? = ""
    static var releaseDate : String? = ""
    static var posterPath : String? = ""
    
    override func setUp() {
        sut = DiscoverPresenter(view: self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getDiscover () {
        sut.interactor = MockInteractor()
        sut.getDiscoverMovies()
        XCTAssertEqual(sut.pageResults.listData.count , 3 )
        XCTAssertEqual(sut.getMoviesCount() , 3 )
    }
    
    func test_callPagination () {
        sut.interactor = MockInteractor()
        sut.pageResults.setDataPagination(listData: MockData.results , currentPage: 2 , totalPages: 5)
        sut.callPaginate(index: 2)
        XCTAssertEqual(DiscoverPresenterTests.callPagination , 3 )
    }
    
    func test_configurationMovies() {
        sut.interactor = MockInteractor()
        sut.pageResults.setDataPagination(listData: MockData.results , currentPage: 2 , totalPages: 5)
        sut.configurationMovies(cell: MockCell(), index: 0)
        XCTAssertEqual(DiscoverPresenterTests.posterPath, MockData.results[0].posterPath)
        XCTAssertEqual(DiscoverPresenterTests.releaseDate, MockData.results[0].releaseDate)
        XCTAssertEqual(DiscoverPresenterTests.overview, MockData.results[0].overview)
        XCTAssertEqual(DiscoverPresenterTests.originalTitle, MockData.results[0].originalTitle)
    }
    
    
}
extension DiscoverPresenterTests : ProDiscoverView {
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

extension DiscoverPresenterTests {
    
    class MockInteractor : DiscoverInteractor {
        
        override func getDiscoverMovies(page: Int, compltion: @escaping CompletionHandler<ModelDiscover>) {
            
            DiscoverPresenterTests.callPagination = page
            compltion( MockData.discover , nil , 200)
        }
    }
    
}

extension DiscoverPresenterTests {
    
    class MockCell : ConfigurationCell {
        
        func setThumbnail(thum: String) {
            DiscoverPresenterTests.posterPath = thum
        }
        
        func setName(name: String) {
            DiscoverPresenterTests.originalTitle = name
        }
        
        func setReleaseDate(date: String) {
            DiscoverPresenterTests.releaseDate = date
        }
        
        func setOverview(overview: String) {
            DiscoverPresenterTests.overview = overview
        }
    }
}
 
