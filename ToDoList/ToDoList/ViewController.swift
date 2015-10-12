//
//  ViewController.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/4/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ToDoListItemDelegate{
    @IBOutlet var toDoList: UITableView!
    
    var toDoListItems = [ToDoListItem]()
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        print("Unwinding to table ... ")
    }
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! NewToDoListItemViewController
        
        if let newTodDoItem:ToDoListItem = source.newToDoItem {
            if newTodDoItem.task.string != "" {
                self.toDoListItems.append(newTodDoItem)
                self.toDoList.reloadData()
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.toolbarHidden = true
    
    }
    

    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black;
        self.navigationController?.navigationBar.translucent = false;
        super.viewDidLoad()

        
        if (toDoListItems.count > 0 ){
            return
        }

    
        toDoList.dataSource = self
        toDoList.delegate = self
        toDoList.registerClass(ToDoListCell.self, forCellReuseIdentifier: "toDoListCell")
        // Do any additional setup after loading the view, typically from a nib.
        
        toDoList.rowHeight = 60
        toDoList.separatorStyle = .None
        toDoList.backgroundColor = UIColor.blackColor()
        
        
        //Delete items that are more than one day old.
        
        for var index = 0; index < toDoListItems.count; index++ {
            if NSDate().timeIntervalSinceDate(toDoListItems[index].dateCompleted) >= 24*60*60 {
                toDoListItems.removeAtIndex(index)
            }
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    @IBOutlet weak var statsButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        
        
        
        var completedInLastDay = 0;
        
        for var index = 0; index < toDoListItems.count; index++ {
            if NSDate().timeIntervalSinceDate(toDoListItems[index].dateCompleted) <= 24*60*60 && toDoListItems[index].isCompleted == true {
                completedInLastDay++
            }
        }
        if (segue.destinationViewController is StatsViewController){
                    let statsVC = segue.destinationViewController as! StatsViewController
            statsVC.numCompleted = completedInLastDay
            
        }
        
    }
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var cell = tableView.dequeueReusableCellWithIdentifier("toDoListCell", forIndexPath: indexPath) as! ToDoListCell
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            let item = toDoListItems[indexPath.row]
//            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.delegate = self
            cell.toDoListItem = item
            cell.textLabel?.attributedText = item.task
            
            return cell
    }
    
    func deleteToDoListItem(toDoListItem: ToDoListItem) {
        let indexOfItem = (toDoListItems as NSArray).indexOfObject(toDoListItem)
        if indexOfItem == NSNotFound{
            //Couldn't find the list item to delete (SHOULD NOT HAPPEN)
            return
        }
        toDoListItems.removeAtIndex(indexOfItem)
        
        toDoList.beginUpdates()
        let indexPath = NSIndexPath(forRow: indexOfItem, inSection: 0)
        toDoList.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        toDoList.endUpdates()
        
    }
    
    func completeToDoListItem(toDoListItem: ToDoListItem) {
        let indexOfItem = (toDoListItems as NSArray).indexOfObject(toDoListItem)
        if indexOfItem == NSNotFound{
            //Couldn't find the list item to mark complete (SHOULD NOT HAPPEN)
            return
        }
        let match = toDoListItems[indexOfItem]
        
        if !match.isCompleted{
            match.addStrikeThrough()
            match.setCompleted()
        }
        else{
            match.removeStrikeThrough()
            match.setUncompleted()
            
        }
        
        toDoList.beginUpdates()
        let indexPath = NSIndexPath(forRow: indexOfItem, inSection: 0)
        toDoList.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        toDoList.endUpdates()
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if (cell as! ToDoListCell).toDoListItem?.isCompleted == true {
                cell.backgroundColor = UIColor(red: 0.2, green: 1.0 , blue: 0.2, alpha: 1.0)
            }
            else{
                cell.backgroundColor = colorForIndex(indexPath.row)
            }
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoListItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return  UIColor(red: 1, green: val, blue: 0.0, alpha: 1.0)
    }



}

