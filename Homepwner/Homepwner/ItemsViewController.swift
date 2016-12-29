//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by BorkoTomic on 12/27/16.
//  Copyright © 2016 BorkoTomic. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(sender: AnyObject)
    {
        //Create new item and add it to the itemstore
        let newItem = itemStore.createItem()
        
        //Find out where the new item is in the store array
        if let index = itemStore.allItems.index(of: newItem)
        {
            let indexPath = IndexPath(row: index, section: 0)
            
            //inserts the new item in table view
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject)
    {
        if isEditing
        {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: false)
        }
        else
        {
            
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: false)
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection:Int) -> Int
    {
        return itemStore.allItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = 	UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        
        /*
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"*/
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            let item = itemStore.allItems[indexPath.row]
            
            //Confirmation alert window
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title:title, message:message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: {(action) -> Void in
                
                
                //Actual remove of the item from the item store
                self.itemStore.remove(item: item)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            
            //Present the alert controller
            present(ac, animated: true, completion: nil)
        

        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        itemStore.moveItemAt(index: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top:statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets  = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    


}
