//
//  DetailItemCell.swift
//  FeedLayout
//
//  Created by N.A Shashank on 15/10/18.
//  Copyright © 2018 Razorpay. All rights reserved.
//

import UIKit

class DetailItemCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    func setData(dataSource:DetailItemModel) {
        self.lblTitle.text = dataSource.title
        self.backgroundColor = dataSource.backgroundColor
    }
}
