//
//  MasterViewController.swift
//  ToggleCellSwipe
//
//  Created by Beat Besmer on 02/06/15.
//  Copyright (c) 2015 example. All rights reserved.
//

import UIKit
import SWTableViewCell

class MasterViewController: UITableViewController, SWTableViewCellDelegate {

    var objects = [AnyObject]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! NSDate
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SWTableViewCell

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        cell.leftUtilityButtons = leftButtons
        cell.delegate = self
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: - Toggle Swipe Gesture
    
    var leftButtons : [AnyObject]{
        var buttons = NSMutableArray()
        buttons.sw_addUtilityButtonWithColor(UIColor.greenColor(), icon: UIImage(named: "eye"))
        buttons.sw_addUtilityButtonWithColor(UIColor.redColor(), icon: UIImage(named: "eye-blocked"))
        
        let x = NSArray(array: buttons)
        for button in x as! [UIButton]{
            button.imageView?.contentMode = .ScaleAspectFit
        }
        
        return buttons as [AnyObject]
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
        
        cell.hideUtilityButtonsAnimated(true)
        
        let makeVisible = (index == 0)
        
        cell.textLabel!.text = makeVisible ? "Visible" : "Invisible"
    }
    
    
}

