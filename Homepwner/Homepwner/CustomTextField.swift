//
//  CustomTextField.swift
//  Homepwner
//
//  Created by borko on 1/7/17.
//  Copyright © 2017 BorkoTomic. All rights reserved.
//

import UIKit

class CustomTextField: UITextField{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.borderStyle = .none
    }
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.borderStyle = .roundedRect
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.borderStyle = .none
        return true
    }
    

}
