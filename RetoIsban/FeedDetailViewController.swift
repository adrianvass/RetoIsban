//
//  FeedDetailViewController.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedDetailViewController: UIViewController {
    let feedViewModel: FeedItemViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    init(_ feedItem: FeedItemViewModel) {
        self.feedViewModel = feedItem
        super.init(nibName: "FeedDetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
    }
    
    private func configViews() {
        self.title = "Detalle"
        self.titleLabel.text = feedViewModel.title
        self.content.text = feedViewModel.content
        if let imageUrl = feedViewModel.imageUrl, let url = URL(string: imageUrl) {
            self.image.kf.setImage(with: url)
        }
    }
    @IBAction func openOnSafary(_ sender: Any) {
        if let url = URL(string: feedViewModel.link) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
