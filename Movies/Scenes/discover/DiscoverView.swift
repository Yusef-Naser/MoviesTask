//
//  DiscoverView.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//VC

import UIKit


class DiscoverView : UIView {
    
    let tableView : UITableView = {
        let l = UITableView()
        l.tableFooterView = UIView()
        l.register(MovieCell.self , forCellReuseIdentifier: MovieCell.getIdentifier())
        l.backgroundColor = .white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        self.addSubview(tableView)
        tableView.anchor(top: topAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor , paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8 )
    }
    
    func setDelegate (delegate : DiscoverVC){
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
    
}
