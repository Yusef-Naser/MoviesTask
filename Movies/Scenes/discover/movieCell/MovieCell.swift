//
//  movieCell.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

protocol ConfigurationCell  {
    func setThumbnail(thum : String)
    func setName (name : String)
    func setReleaseDate(date : String)
    func setOverview (overview : String)
}

class MovieCell : UITableViewCell {
    
    private let imageThum : UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        l.layer.cornerRadius = 10
        return l
    }()
    
    private let labelName : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20)

        return l
    }()
    
    private let labelOverview : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.numberOfLines = 2
        l.lineBreakMode = .byWordWrapping

        return l
    }()
    
    private let labelReleaseData : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
       
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        initViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    private func initViews () {
        addViews()
        self.selectionStyle = .none
       
    }
    private func addViews () {
        self.contentView.addSubview(imageThum)
        self.contentView.addSubview(labelName)
        self.contentView.addSubview(labelOverview)
        self.contentView.addSubview(labelReleaseData)
        
        imageThum.anchor(top: contentView.topAnchor , leading: contentView.leadingAnchor , bottom: contentView.bottomAnchor , paddingTop: 4, paddingLeft: 4, paddingBottom: 4 , width: 80 , height: 100 )
        labelName.anchor(top: contentView.topAnchor , leading: imageThum.trailingAnchor , trailing: contentView.trailingAnchor , paddingTop: 4 , paddingLeft: 8, paddingRight: 8 )
        labelOverview.anchor(top: labelName.bottomAnchor , leading: imageThum.trailingAnchor , trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8 , paddingRight: 8 )
        labelReleaseData.anchor( bottom: contentView.bottomAnchor , trailing: contentView.trailingAnchor  , paddingBottom: 8 , paddingRight: 8 )
        
    }
    
}

extension MovieCell : ConfigurationCell {
    
    func setThumbnail(thum: String) {
        self.imageThum.loadImage(url: thum)
    }
    
    func setName(name: String) {
        self.labelName.text = name
    }
    
    func setReleaseDate(date: String) {
        self.labelReleaseData.text = date
    }
    
    func setOverview(overview: String) {
        self.labelOverview.text = overview
    }
    
}
