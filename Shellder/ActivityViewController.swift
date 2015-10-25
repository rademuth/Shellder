//
//  ActivityViewController.swift
//  Shellder
//
//  Created by Robert Demuth on 10/20/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var xCoorTextField: UITextField!
    @IBOutlet weak var yCoorTextField: UITextField!

    /*
    This value is either passed by `ActivityTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new activity.
    */
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
            activity = Activity(id: 0, title: title, latitude: NSString(string: xCoorText).floatValue, longitude: NSString(string: yCoorText).floatValue, photo: nil, complete: false)
        }
    }
    
    // MARK: Actions
    

}

