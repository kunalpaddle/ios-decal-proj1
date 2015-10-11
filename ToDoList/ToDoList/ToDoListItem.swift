//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/4/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import UIKit

class ToDoListItem: NSObject {
    var task : String
    var isCompleted: Bool
    
    init(task:String){
        self.isCompleted = false
        self.task = task
        
    }

}
