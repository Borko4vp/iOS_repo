//
//  ItemStore.swift
//  Homepwner
//
//  Created by BorkoTomic on 12/27/16.
//  Copyright © 2016 BorkoTomic. All rights reserved.
//

import UIKit

class ItemStore
{
    var allItems = [Item]()

    
    let itemArchiveURL: URL = {
        //var docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).first!.appendingPathComponent("items.archive")
    }()
    

    func createItem() -> Item
    {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func remove(item: Item)
    {
        if let indexToRemove = allItems.index(of: item)
        {
            allItems.remove(at: indexToRemove)

        }
    }
    
    func moveItemAt(index: Int, toIndex: Int)
    {
        if index == toIndex
        {
            return
        }
        let movedItem = allItems[index]
        //remove item at index
        allItems.remove(at: index)
        //reinserts the item at toIndex
        allItems.insert(movedItem, at: toIndex)
    }
    func saveChanges() -> Bool
    {
        print("saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    //this is commented out since we implemented method for adding the cells into the table
    //this can be reused in testing purposes later on
    /*init()
    {
        for _ in 0..<5
        {
            createItem()
        }
    }*/
    init()
    {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item]
        {
            allItems += archivedItems
        }
    }

}


