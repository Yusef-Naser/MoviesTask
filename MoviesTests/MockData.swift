//
//  TestData.swift
//  MoviesTests
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

@testable import Movies

class MockData {
    
    static let results : [ModelResult] = [ ModelResult(popularity: 1, voteCount: 1, video: false , posterPath: "posterPath_1", id: 1, adult: false , backdropPath: "", originalLanguage: "en", originalTitle: "originalTitle_1", genreIDS: [1], title: "title_1", voteAverage: 3, overview: "overview_1", releaseDate: "releaseDate_1") ,
    ModelResult(popularity: 2, voteCount: 2, video: false , posterPath: "posterPath_2", id: 2, adult: false , backdropPath: "", originalLanguage: "en", originalTitle: "originalTitle_2", genreIDS: [1], title: "title_2", voteAverage: 3, overview: "overview_2", releaseDate: "releaseDate_2") ,
    ModelResult(popularity: 3, voteCount: 3, video: false , posterPath: "posterPath_3", id: 3, adult: false , backdropPath: "", originalLanguage: "en", originalTitle: "originalTitle_3", genreIDS: [1], title: "title_3", voteAverage: 3, overview: "overview_3", releaseDate: "releaseDate_3") ]
    static let discover = ModelDiscover(page: 1, totalResults: 20, totalPages: 300, results: results)
    
}
