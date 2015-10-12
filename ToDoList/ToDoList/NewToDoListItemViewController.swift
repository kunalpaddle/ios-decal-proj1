//
//  NewToDoListItemViewController.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/11/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import Foundation
import UIKit



class NewToDoListItemViewController: UIViewController {
    @IBOutlet weak var newItemTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var newToDoItem: ToDoListItem?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (self.newItemTextField.text?.isEmpty == false) {
            self.newToDoItem = ToDoListItem(taskString: self.newItemTextField.text!)
        }
        
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false
    }
    
    
}
