//
//  FeedTableViewRepository.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation
import FeedKit

final class FeedTableViewRepository {
    let cacheProvider: CacheProvider<[FeedItem]>
    
    init(cacheProvider: CacheProvider<[FeedItem]>) {
        self.cacheProvider = cacheProvider
    }
    
    func getFeedItems(feedUrl: String, fromCache: Bool = true, completion: @escaping ([FeedItem]) -> Void) {
        if let items = getFeedItemsFromCache(feedUrl: feedUrl), fromCache {
            completion(items)
        }
        else {
            getFeedItemsFromNetwork(feedUrl: feedUrl, completion: completion)
        }
    }

    private func getFeedItemsFromCache(feedUrl: String) -> [FeedItem]? {
        return cacheProvider.retrieve(forKey: feedUrl)
    }
    
    // Querys the network for data, and in case of no data or error,
    // returns cached data if any.
    private func getFeedItemsFromNetwork(feedUrl: String, completion: @escaping ([FeedItem]) -> Void) {
        var feedItems = [FeedItem]()
        
        if let cachedItems = self.getFeedItemsFromCache(feedUrl: feedUrl) {
            feedItems = cachedItems
        }
        
        guard let url = URL(string: feedUrl), let parser = FeedParser(URL: url) else {
            completion(feedItems)
            return
        }
        
        parser.parseAsync { result in
            guard let feed = result.rssFeed, let items = feed.items, result.isSuccess else {
                completion(feedItems)
                return
            }
                
            feedItems = items.map({ (rssItem) -> FeedItem in
                let title = rssItem.title ?? "Desconocido"
                let content = rssItem.description ?? "Descripción desconocida"
                let date = rssItem.pubDate ?? Date()
                let link = rssItem.link ?? ""
                let imageUrl = rssItem.enclosure?.attributes?.url
                
                return FeedItem(title: title, content: content, imgUrl: imageUrl, link: link, date: date)
            })
            
            if feedItems.count > 0 { self.cacheProvider.persist(feedItems, forKey: feedUrl) }
            
            completion(feedItems)
        }
    }
}
