//
//  SearchMoviesInteractor.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//VC


class SearchMoviesInteractor {
    
    func getSearchMovies (text : String , page : Int , compltion : @escaping CompletionHandler<ModelDiscover> ) {
        
       ApiClient<ModelDiscover>.performRequest(route: .search(text: text , page: page )) { (result , statusCode) in
           switch result {
           case .success(let data) :
               compltion(data , nil , statusCode)
               return
           case .error(let error) :
               compltion(nil , error , statusCode)
               return
           }
       }
        
   }
    
}
