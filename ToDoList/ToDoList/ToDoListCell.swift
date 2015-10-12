//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by Kunal Patel on 10/10/15.
//  Copyright © 2015 Kunal Patel. All rights reserved.
//

import UIKit

protocol ToDoListItemDelegate {
    func deleteToDoListItem(toDoListItem: ToDoListItem)
    func completeToDoListItem(toDoListItem: ToDoListItem)
}

class ToDoListCell: UITableViewCell {
    var shouldDeleteCell = false
    var shouldMarkComplete = false
    var origin = CGPoint()
    var toDoListItem : ToDoListItem?
    var delegate: ToDoListItemDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        var panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panRecognizer.delegate = self
        addGestureRecognizer(panRecognizer)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: NSCoder) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        //Find the center
        if recognizer.state == .Began{
            origin = center
        }
        
        if recognizer.state == .Changed{
            // How far did we move in the X-direction?
            let translation = recognizer.translationInView(self)
            center = CGPointMake(origin.x + translation.x, origin.y)
            shouldDeleteCell = frame.origin.x < -1*frame.size.width / 2.2
            shouldMarkComplete = frame.origin.x > frame.size.width / 2.2
            
            
            
        }
        
        if recognizer.state == .Ended {
            
            let originalCell = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            
            //If we don't drag the cell to the right threshold X, return it to original position.
            if !shouldDeleteCell && !shouldMarkComplete{
                UIView.animateWithDuration(0.3, animations: {self.frame = originalCell})
            }
            
            if(shouldDeleteCell && delegate != nil && toDoListItem != nil){
                delegate!.deleteToDoListItem(toDoListItem!)
            }
            
            if(shouldMarkComplete && delegate != nil && toDoListItem != nil){
                delegate!.completeToDoListItem(toDoListItem!)
            }
            
        }
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        // We don't want vertical pans.
        if let pan = gestureRecognizer as? UIPanGestureRecognizer{
            let translation = pan.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
            }
        return false
        }
}
