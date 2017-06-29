//
//  FeedItem.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation

class FeedItem: NSObject, NSCoding {
    let title, content, link: String
    let imgUrl: String?
    let date: Date
    
    init(title: String, content: String, imgUrl: String?, link: String, date: Date) {
        self.title = title
        self.content = content
        self.imgUrl = imgUrl
        self.link = link
        self.date = date
    }
    
    var toCellViewModel: FeedItemViewModel {
        return FeedItemViewModel(title: title, content: content, link: link, imageUrl: imgUrl)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String,
              let content = aDecoder.decodeObject(forKey: "content") as? String,
              let imgUrl = aDecoder.decodeObject(forKey: "imgUrl") as? String?,
              let link = aDecoder.decodeObject(forKey: "link") as? String,
              let date = aDecoder.decodeObject(forKey: "date") as? Date else { return nil }
        
        self.init(title: title, content: content, imgUrl: imgUrl, link: link, date: date)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(imgUrl, forKey: "imgUrl")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(link, forKey: "link")
    }
}
