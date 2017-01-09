//
//  DateChangerViewController.swift
//  Homepwner
//
//  Created by borko on 1/7/17.
//  Copyright © 2017 BorkoTomic. All rights reserved.
//

import UIKit

class DateChangerViewController: UIViewController
{
    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.date = item.dateCreated as Date
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date as NSDate
    }
    
}
