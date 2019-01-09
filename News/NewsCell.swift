//
//  NewsCell.swift
//  News
//
//  Created by Salman on 1/7/18.
//  Copyright © 2018 cannypope. All rights reserved.
//

import UIKit

class NewsCell : UICollectionViewCell{
    
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var authorField: UILabel!
    
    @IBAction func menuBtnAction(_ sender: UIButton){
        if self.menuAction != nil{
            self.menuAction!()
        }
    }
    var menuAction: (() -> Void)?
}
