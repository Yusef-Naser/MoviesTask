//
//  DiscoverInteractorTests.swift
//  MoviesTests
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import XCTest
@testable import Movies

class DiscoverInteractorTests : XCTestCase {
    
    var sut : DiscoverInteractor!
    
    override func setUp() {
        sut = DiscoverInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_Discover() {
        let e = expectation(description: "discover")
        sut.getDiscoverMovies(page: 1) { (data , error, statusCode) in
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
