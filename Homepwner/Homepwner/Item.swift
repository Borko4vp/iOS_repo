//
//  Item.swift
//  Homepwner
//
//  Created by BorkoTomic on 12/27/16.
//  Copyright © 2016 BorkoTomic. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding
{
    var name : String = ""
    var valueInDollars: Int = 0
    var serialNumber: String?
    var dateCreated: NSDate
    
    var itemKey: String
    
    init(name:String, serialNumber: String?, valueInDollars:Int){
    
        self.name=name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().uuidString
        
        super.init()
    }
    
    convenience init(random: Bool = false)
    {
        if(random)
        {
            let adjectives=["Fluffy", "Rusty", "Shiny", "Greedy", "Crazy"]
            let nouns = ["Bear", "Spork", "Mac", "Rabbit", "SpiderPig"]
            
            var idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            let randomName = " \(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            
            let randomSerialNumber  = NSUUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else
        {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    
    }
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! NSDate
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encodeCInt(Int32(valueInDollars), forKey: "valueInDollars")
    }
}
