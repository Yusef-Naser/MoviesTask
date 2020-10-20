//
//  ApiRouter.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import Foundation


public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

enum ApiRouter : URLRequestConvertible {
    
    case discover(page : Int)
    case search (text : String , page : Int )
    
    private var Methods : String {
        switch self {
        case .discover, .search :
            return "GET"
        }
    }
    
    private var Headers : [String : String] {
        switch self {
        case .discover , .search :
            return [
                "content-type" : "application/json;charset=utf-8",
                "Authorization" : "Bearer \(API_TOKEN)"
            ]
        }
    }
    
    private var Paths : String {
        switch self {
        case .discover(let page ):
            return "/discover/movie?language=en-US&include_adult=false&include_video=false&page=\(page)"
        case .search(let text, let page ) :
            return "/search/movie?language=en-US&query=\(text)&page=\(page)&include_adult=false"
        }
    }
    
    func asURLRequest() -> URLRequest {
        let url = "\(BASE_URL)\(Paths)"
        let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var urlRequest = URLRequest(url: URL(string: safeUrl!)!)
        urlRequest.allHTTPHeaderFields = Headers
        return urlRequest
        
    }
    
}
