//
//  File.swift
//  Homepwner
//
//  Created by BorkoTomic on 12/27/16.
//  Copyright © 2016 BorkoTomic. All rights reserved.
//

import UIKit

class ItemStore
{
    var allItems = [Item]()
    
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
    //this is commented out since we implemented method for adding the cells into the table
    //this can be reused in testing purposes later on
    /*init()
    {
        for _ in 0..<5
        {
            createItem()
        }
    }*/

}


