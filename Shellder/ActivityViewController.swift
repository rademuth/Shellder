//
//  ActivityViewController.swift
//  Shellder
//
//  Created by Robert Demuth on 10/20/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import CoreData

class ActivityViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var xCoorTextField: UITextField!
    @IBOutlet weak var yCoorTextField: UITextField!

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /*
    This value is either passed by `ActivityTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new activity.
    */
    var size: Int?
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        // Handle the text field's user input through delegate callbacks
        titleTextField.delegate = self
        xCoorTextField.delegate = self
        yCoorTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidActivityName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidActivityName()
    }
    
    func checkValidActivityName() {
        // Disable the Save button if the text field is empty.
        let title = titleTextField.text ?? ""
        saveButton.enabled = !title.isEmpty
        
        // Check that the other fields contain valid numbers
        let xCoorText = NSString(string: xCoorTextField.text ?? "")
        let yCoorText = NSString(string: yCoorTextField.text ?? "")
        
        if xCoorText.length != 0 {
            let xNum = xCoorText.floatValue
            if xNum == 0 {
                saveButton.enabled = false
            }
        }
        
        if yCoorText.length != 0 {
            let yNum = yCoorText.floatValue
            if yNum == 0 {
                saveButton.enabled = false
            }
        }
        
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let title = titleTextField.text ?? ""
            let xCoorText = xCoorTextField.text ?? "0"
            let yCoorText = yCoorTextField.text ?? "0"
            
            // Set the activity to be passed to ActivityTableViewController after the unwind segue.
            activity = NSEntityDescription.insertNewObjectForEntityForName("Activity", inManagedObjectContext: managedObjectContext) as? Activity
            
            activity!.id = size! + 1
            activity!.title = title
            activity!.latitude = NSString(string: xCoorText).floatValue
            activity!.longitude = NSString(string: yCoorText).floatValue
            activity!.photo = nil
            activity!.complete = 0
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Failed to save the new activity. Error = \(error)")
            }
            
        }
    }
    
    // MARK: Actions
    

}

