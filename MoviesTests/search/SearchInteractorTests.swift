//
//  SearchInteractorTests.swift
//  MoviesTests
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import XCTest
@testable import Movies

class SearchInteractorTests : XCTestCase {
    
    var sut : SearchMoviesInteractor!
    
    override func setUp() {
        sut = SearchMoviesInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getSearchMovies () {
        let e = expectation(description: "search")
        sut.getSearchMovies(text: "MU", page: 1) { (data, error , statusCode) in
            e.fulfill()
            guard let data = data else {
                XCTFail(error?.localizedDescription ?? "")
                return
            }
            XCTAssertEqual(statusCode , 200 )
        }
        waitForExpectations(timeout: 5 , handler: nil )
    }
    
    
}
