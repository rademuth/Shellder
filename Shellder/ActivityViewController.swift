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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    /*
    This value is either passed by `ActivityTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new activity.
    */
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        // Handle the text field's user input through delegate callbacks
        textField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Update the label text
        label.text = textField.text
        textField.text = ""
    }
    
    // MARK: Actions
    @IBAction func setDefaultLabelText(sender: UIButton) {
        label.text = "Default Text"
    }
    

}

