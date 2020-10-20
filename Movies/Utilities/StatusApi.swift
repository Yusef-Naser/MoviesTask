//
//  StatusApi.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

protocol StatusApi : class  {
    func showMessage (_ message : String )
    func onError(_ message : String  )
    func onFailure (_ message : String  )
    func showLoading ()
    func hideLoading ()
    
}
