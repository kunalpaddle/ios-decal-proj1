//
//  StatsViewController.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/11/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import Foundation
import UIKit


class StatsViewController: UIViewController {
    
    var numCompleted:Int?

    @IBOutlet weak var numCompletedTasksField: UILabel!
    
    func setNumCompletedTasks(numTasks: Int){
        numCompletedTasksField.text = "\(numTasks)"
        
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black  // optional
        self.navigationController?.navigationBar.translucent = false;
        
        if let updatedNumber = numCompleted {
            setNumCompletedTasks(updatedNumber)
            print ("updating to \(updatedNumber)")

        }
    }
    
}