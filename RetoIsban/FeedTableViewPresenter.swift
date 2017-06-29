//
//  FeedTableViewPresenter.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation

final class FeedTableViewPresenter {
    fileprivate let feedRepo: FeedTableViewRepository
    fileprivate let defaultFeed: String = "https://ep00.epimg.net/rss/elpais/ciencia.xml"
    weak private var feedTableView: FeedTableViewDelegate?
    
    init(feedRepo: FeedTableViewRepository) {
        self.feedRepo = feedRepo
    }
    
    func attachView(_ view: FeedTableViewDelegate) {
        self.feedTableView = view
        self.getFeedItems(fromCache: false)
    }
        
    private func getFeedItems(feedUrl: String? = nil, fromCache: Bool) {
        let url = feedUrl ?? defaultFeed
        feedRepo.getFeedItems(feedUrl: url, fromCache: fromCache, completion: { items in
            self.feedTableView?.setFeedItems(items.map { $0.toCellViewModel })
        })
    }
}
