//
//  ImagesModelCacheManager.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/18/23.
//

import Foundation
import SwiftUI

class ImagesModelCacheManager {
    
    static let instance = ImagesModelCacheManager()
    
    private init() {
        
    }
    
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
