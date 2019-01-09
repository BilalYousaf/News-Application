//
//  News.swift
//  News
//
//  Created by Salman on 1/7/18.
//  Copyright © 2018 cannypope. All rights reserved.
//

import UIKit

class NewsModel : NSObject{
    var details: String?
    var author: String?
    var publishedAt: String?
    var title: String?
    var urlToImage: String?
    var url: String?
    var image: UIImage?
    
    override init() {
        
    }
    init(dic: NSDictionary) {
        if let t = dic["title"] as? String{
            self.title = t
        }
        if let a = dic["author"] as? String{
            self.author = a
        }
        if let t = dic["description"] as? String{
            self.details = t
        }
        if let t = dic["url"] as? String{
            self.url = t
        }
        if let t = dic["urlToImage"] as? String{
            self.urlToImage = t
        }
        if let t = dic["publishedAt"] as? String{
            self.publishedAt = t
        }
    }
    
    func getValues() -> [String: Any]{
        let values = ["title": title, "author": author, "details": details, "url": url, "urlToImage": urlToImage, "date": publishedAt]
        return values
    }
}
