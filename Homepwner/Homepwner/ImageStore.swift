//
//  ImageStore.swift
//  Homepwner
//
//  Created by borko on 1/9/17.
//  Copyright © 2017 BorkoTomic. All rights reserved.
//

import UIKit

class ImageStore {

    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image:UIImage, forKey key:String)
    {
        cache.setObject(image, forKey: key as NSString)
    }
    func imageForKey(key: String) -> UIImage?
    {
        return cache.object(forKey: key as NSString) as UIImage!
    }
    func deleteImageForKey(key: String)
    {
        cache.removeObject(forKey: key as NSString)
    }
}
