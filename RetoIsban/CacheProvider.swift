//
//  FeedItemCacheProvider.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation

final class CacheProvider<E> {
    let userDefaults: UserDefaults
    
    init() { self.userDefaults = UserDefaults.standard }
    
    func retrieve(forKey key: String) -> E? {
        guard let decodedData = userDefaults.object(forKey: key) as? Data,
              let element = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? E else { return nil }
        return element
    }
    
    func persist(_ object: E, forKey key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        userDefaults.set(data, forKey: key)
    }
}
