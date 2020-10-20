//
//  MainTabBar.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

class MainTabBar : UITabBarController {
    
    let discover = DiscoverVC()
    let search = SearchMoviesVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    discover.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        discover.tabBarItem = UITabBarItem(title: "Discover", image: #imageLiteral(resourceName: "star") , tag: 0)
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        

        viewControllers = [discover, search]
    }
    
}
