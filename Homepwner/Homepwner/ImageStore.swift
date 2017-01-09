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
    
    func imageURLForKey(key: String)->URL
    {
        return (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent(key)
        
    }
    
    func setImage(image:UIImage, forKey key:String)
    {
        cache.setObject(image, forKey: key as NSString)
        
        //Create full URL for the image to be saved at
        let imageURL  = imageURLForKey(key: key)
        //Turn image into the JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5)
        {
            //write it to full URL
//////            /////Error handling to be implemented properly
            do { try data.write(to: imageURL, options: .atomic) }
            catch{}
            
        }
        
        
    }
    func imageForKey(key: String) -> UIImage?
    {
        if let  existingImage = cache.object(forKey: key as NSString) as UIImage!
        {
            return existingImage
        }
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path)
        else
        {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
        //return cache.object(forKey: key as NSString) as UIImage!
    }
    func deleteImageForKey(key: String)
    {
        cache.removeObject(forKey: key as NSString)
        
        let imageURL = imageURLForKey(key: key)
//////        //Error handling to be implemented properly
        do { try FileManager.default.removeItem(at: imageURL)}
        catch{}
        
    }
}
