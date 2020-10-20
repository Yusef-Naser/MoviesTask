//
//  DelegateSearchHistory.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

class DelegateSearchHistory : NSObject ,  UITableViewDelegate , UITableViewDataSource {
    
    var compltionSearchHistory : ( (String)->Void )?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.instance.getRecent().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.getIdentifier()  , for: indexPath)
        cell.textLabel?.text = SharedData.instance.getRecent()[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        compltionSearchHistory?(SharedData.instance.getRecent()[indexPath.row])
    }
    
}
