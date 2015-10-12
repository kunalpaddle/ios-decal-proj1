//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/4/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import UIKit

class ToDoListItem: NSObject {
    var task : NSMutableAttributedString
    var isCompleted = false
    var dateCompleted: NSDate
    
    init(task: NSMutableAttributedString) {
        self.isCompleted = false
        self.task = task
        self.dateCompleted = NSDate.distantFuture()
        
    }
    
    init(taskString: String){
        self.isCompleted = false
        self.task = NSMutableAttributedString(string: taskString)
        self.dateCompleted = NSDate.distantFuture()
    }
    
    func setCompleted(){
        isCompleted = true
        self.dateCompleted = NSDate()
    }
    
    func setUncompleted(){
        isCompleted = false
        self.dateCompleted = NSDate.distantFuture()
    }
    
    func addStrikeThrough() {
        task.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSRange(location: 0,length: task.length))
    }
    
    func removeStrikeThrough() {
        task.removeAttribute(NSStrikethroughStyleAttributeName, range: NSRange(location: 0, length: task.length))
    }
    
    

}
