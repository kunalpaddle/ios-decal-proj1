//
//  ViewController.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/4/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var toDoList: UITableView!
    
    var toDoListItems = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (toDoListItems.count > 0 ){
            return
        }
        
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: ":)"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))
        toDoListItems.append(ToDoListItem(task: "Write this App"))

     


    
        toDoList.dataSource = self
        toDoList.delegate = self
        toDoList.registerClass(ToDoListCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        
        toDoList.rowHeight = 55
        //toDoList.separatorColor = UIColor.blackColor()
        toDoList.backgroundColor = UIColor.blackColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as ToDoListCell
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            let item = toDoListItems[indexPath.row]
            cell.textLabel?.text = item.task
            return cell
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoListItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.8
        return UIColor(red: 1.0, green: val, blue: 0, alpha: 1.0)
    }



}

