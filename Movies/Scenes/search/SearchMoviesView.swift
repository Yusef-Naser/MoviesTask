//
//  SearchMoviesView.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//VC

import UIKit


class SearchMoviesView : UIView {
    
    let searchBar : UISearchBar = {
        let l = UISearchBar()
        l.showsCancelButton = true
        return l
    }()
    
    let tableView : UITableView = {
        let l = UITableView()
        l.tableFooterView = UIView()
        l.register(MovieCell.self , forCellReuseIdentifier: MovieCell.getIdentifier())
        l.backgroundColor = .white
        l.keyboardDismissMode = .onDrag
        return l
    }()
    
    lazy var tableViewHistory : FitTableView = {
        let l = FitTableView()
        l.tableFooterView = UIView()
        l.register(UITableViewCell.self , forCellReuseIdentifier: UITableViewCell.getIdentifier())
        l.backgroundColor = .white
        l.keyboardDismissMode = .onDrag
        return l
    }()
    
    private let footerView : UILabel = {
        let l = UILabel()
        l.text = "Recent seach"
        l.backgroundColor = .gray
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
        hideRecentView()
    }
    
    private func addViews () {
        
        self.addSubview(searchBar)
        self.addSubview(tableView)
        self.addSubview(tableViewHistory)
        self.addSubview(footerView)
        
        searchBar.anchor(top: safeAreaLayoutGuide.topAnchor , leading: leadingAnchor , trailing: trailingAnchor )
        tableView.anchor(top: searchBar.bottomAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor )
        tableViewHistory.anchor(top: searchBar.bottomAnchor , leading: leadingAnchor , trailing: trailingAnchor )
        footerView.anchor(top: tableViewHistory.bottomAnchor , leading: tableViewHistory.leadingAnchor , trailing: tableViewHistory.trailingAnchor , paddingLeft: 16 , paddingRight: 16 , height: 40 )
        
    }
    
    func setDelegate (delegate : SearchMoviesVC) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
        searchBar.delegate = delegate
    }
    
    func showRecentView (){
        self.tableViewHistory.isHidden = false
        self.footerView.isHidden = false
        tableViewHistory.reloadData()
    }
    
    func hideRecentView () {
        self.tableViewHistory.isHidden = true
        self.footerView.isHidden = true
    }
    
}
