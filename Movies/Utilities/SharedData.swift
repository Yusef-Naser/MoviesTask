//
//  SharedData.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import Foundation

class SharedData {

    static var instance = SharedData()
    private var userDefaults = UserDefaults.standard

    
    private let recentKey = "recentKey"
    
    
    
    private init(){
        
    }
    
    func setRecent (text : String) {
        if var array = userDefaults.array(forKey: recentKey) as? [String] {
            if array.count >= 8 {
                array.remove(at: 0)
            }
            if !array.contains(text) {
                array.append(text)
            }
            userDefaults.set(array, forKey: recentKey)
        }else {
            userDefaults.set([text], forKey: recentKey)
        }
    }

    func getRecent () -> [String] {
        (userDefaults.array(forKey: recentKey) as? [String] ) ?? []
    }
    
}
