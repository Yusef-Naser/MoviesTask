//
//  FitTableView.swift
//  Movies
//
//  Created by yusef naser on 10/20/20.
//  Copyright © 2020 Corneteleveted. All rights reserved.
//

import UIKit

class FitTableView : UITableView {
    
    override var contentSize:CGSize {
           didSet {
               self.invalidateIntrinsicContentSize()
           }
       }

       override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
        self.isScrollEnabled = false
            return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
       }
    
}
