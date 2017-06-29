//
//  FeedItemCellView.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedItemCellView: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {}
    
    func configCell(_ item: FeedItemViewModel) {
        title.text = item.title
        content.text = item.content
        if let strUrl = item.imageUrl, let url = URL(string: strUrl) {
            thumbnail.kf.setImage(with: url)
        }
    }
}
