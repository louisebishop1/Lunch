//
//  Item.swift
//  Lunch
//
//  Created by Louise Bishop on 26/01/2015.
//  Copyright (c) 2015 Steer. All rights reserved.
//

import Foundation

class Item {
    
    var name = ""
    var quantity = ""
    var checked = false
    var iconName = "Other"
    
    
    //Add a method that sets the value of checked to equal the opposite of what it is
    
    func toggleChecked() {
        checked = !checked
    }
    
}
