//
//  AddItemViewController.swift
//  Lunch
//
//  Created by Louise Bishop on 26/01/2015.
//  Copyright (c) 2015 Steer. All rights reserved.
//

import UIKit

//Aim is to connect up our save button, to allow us to save information to our listTableViewController
//Step 1 add in our protocol class for our delegate

protocol AddItemViewControllerDelegate : class {
    //This method allows us to send our Item back to our ListViewcontroller
    func addItemViewControllerDidSave(controller: AddItemViewController, item: Item)
    //This method will allow us to attach functionality to our cancel button
    func addItemViewControllerDidCancel(controller: AddItemViewController)
}

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    //Step 2: Add an empty property, that will be filled with our delegate,
    // when we do our segue
    var delegate : AddItemViewControllerDelegate? = nil
    //We add in a property called iconPressed, so we can set the value of our segemented control to it.
    //We then assign it to our iconName property inside our save function
    var iconPressed = "Other"

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //Step 3: Added in our save button functionality
    //Creating a new Item object.
    //We then add in our protocol method, and pass to it
    // our item object
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        
        var item = Item()
        item.name = nameTextField.text
        item.quantity = quantityTextField.text
        item.iconName = iconPressed
        println(item.iconName)
        delegate?.addItemViewControllerDidSave(self, item: item)
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    
    @IBAction func segmentSelected(sender: UISegmentedControl) {
        /*
        switch someValueToConsider {
        case value1:
            respond to value1
        case value2:
            respond to value2
        case value3:
            respond to value3
        default
            otherwise do something else
        }
        */
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            iconPressed = "FruitVeg"
            println(iconPressed)
        case 1:
            iconPressed = "Meat"
            println("Meat")
        case 2:
            iconPressed = "Fish"
            println("Fish")
        default:
            iconPressed = "Other"
            println("Other")
        }
    }
  
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Item"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //First declare we are the UITextFieldDelegate at the top of our page
    // This is one of our UITextFieldDelegate methods. It is invoked every time the
    //user changes the text, whether by tapping on the keyboard, or by cut and paste
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
                //First we need to set a constant holding our old text
        
                let oldText : NSString = textField.text
                //Secondly we need to set a constant holding our new text
                let newText : NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
                //We need to add an if statement, that checks the length of our new text, and enables/disables our save button accordingly.
        
        if newText.length > 0 {
            saveButtonPressed.enabled = true
        } else {
            saveButtonPressed.enabled = false
            }
       // saveButtonPressed.enabled = (newText.length > 0)
        return true
        
    }
}
