//
//  ModelDiscover.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

struct ModelDiscover: Codable {
    let page, totalResults, totalPages: Int?
    let results: [ModelResult]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

