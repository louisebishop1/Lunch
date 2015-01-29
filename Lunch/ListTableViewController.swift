//
//  ListTableViewController.swift
//  Lunch
//
//  Created by Louise Bishop on 26/01/2015.
//  Copyright (c) 2015 Steer. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, AddItemViewControllerDelegate {

    //This creates an empty array that will hold only Item objects
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.title = "Lunch"
        
      
        let item1 = Item()
        item1.name = "Add Item here"
        item1.quantity = "Add quantity"
        item1.iconName = "Other"
        item1.checked = true
        self.items += [item1]
        
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //1 Add in reuseidentifer for our prototype cell.
        // this line creates a new instance of a UITableViewCell object
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        //2 This line accesses the item at a specified row inside our array.
        let item = self.items[indexPath.row]
        
        //3 Set our text labels
        // First access our cell property textLabel (which is a UILabel? object)
        // Then access UILabels text property text
        // Then set this to our item property name
        
        //We use an exclamation mark after textLabel and detailTextLabel because we
        //are unwrapping an optional value. Note only use this way of unwrapping optional
        //if you are certain that there will ALWAYS be a value
        

        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = item.quantity
        
        //Here we want to display our icon inside of our cell
        //Our cell comes with an imageView property
        //We can set this by accessing imageView's image property
        //We then use a UIImage method that allows us to set our image by
        //using its file name.
        //As we have been using the same filename inside of our app ie. FruitVeg,
        //Fish, Meat, Other - we can put in the value of item.iconName in here
        cell.imageView!.image = UIImage(named: item.iconName)
        
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }
    
    // MARK: - Checkmark
    
    //We are using didSelectRowAtIndexPath in order to add a checkmark to our cell, when the 
    //cell has been selected.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Check if there definitely is a cell at this indexpath
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            //At the moment our cell is not connected to our model. We want our checkmark to display depening on whether our checked value is true or false
            let item = items[indexPath.row]
            
            item.toggleChecked()
            
            //Here we check if our cell has a checkmark, if it doesn't- add one.
            //If it does, remove it.
            if item.checked {
                cell.accessoryType = .Checkmark
                println(item.checked)
            } else {
                cell.accessoryType = .None
            }
            
            
        }
        //After we have selected our row, we want to deselect it.
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }*/


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            self.items.removeAtIndex(indexPath.row)
            
        
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    //Here we want to rearrage the order of our data, so that if we re-open our app, the
    //order will be preserved.
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        //First get a reference to the item that is inside the row we want to move from
        let item = items[fromIndexPath.row]
        //Next remove this item
        items.removeAtIndex(fromIndexPath.row)
        //Insert the item back into our array
        items.insert(item, atIndex: toIndexPath.row)
        println(item.name)

    }
    

    //This method allows us to rearrange our tableView cells, but doesn't change our data
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation. Here we can add
    // any information that we want to pass to our new instance
    // of AddItemViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        //Only run this piece of code, if our segue is equal to AddItem
        if segue.identifier == "AddItem" {
        //Add ourselves to the delegate property on our AddItemViewController
            
            //First lets get a reference to our navgation controller, that we are
            //seguing to. We have to tell Xcode what kind of object this is going to be
            //by using 'as UINavigationController'
            let navigationController = segue.destinationViewController as UINavigationController
            
            //Second we need a reference to our AddItemViewController
            //Here we use topViewController, to access whatever controller is on the top of 
            //our navigation stack. Your navigation stack contains navigation controllers,
            //and your other views. They sit on top of on another. The hierarchy would be 
            //as follows:
            
            //AddItem View Controller
            //Navigation Controller
            //List Table View Controller
            //Navigation Controller
            
            //When we dismiss a view controller, it is removed from the stack, and the reference to it in memory is removed.
            
            // topViewController gets a reference to the top view, but xcode can't be sure
            // of what that object is going to be, so we need to tell it to treat it as
            // our AddItemViewController, so we can access its delegate property.
            let controller = navigationController.topViewController as AddItemViewController
            
            controller.delegate = self
        }
        
    }


    // MARK: - Protocol methods
    
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewControllerDidSave(controller: AddItemViewController, item: Item) {
        
        //Aim is to add our item passed by AddItemTableViewController
        //to our tableView
        
        //We want to use the insertRowsAtIndexPath method
        //This is what we need to create:
        
        //An array of NSIndexPath objects each representing a row index and section index that together identify a row in the table view.
        
        //First lets get the row index
        //This counts how many items are in our array curently, and returns this number. At the moment this is 2.
        //This actually will correspond to third row in our table, 
        //as our table counts from 0.
        let newRowIndex = items.count
        
        //Add our new item to our array
        //self.items += [item]
        items.append(item)
        
        //Add our newRowIndex and section number into an NSIndexPath
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        //Add our indexPath into an array
        let indexPathArray = [indexPath]
        // Now add our indexPathArray into our method
        tableView.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: .Automatic)
        
        //Dismiss our view controller
        dismissViewControllerAnimated(true , completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
