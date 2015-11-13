//
//  ProgressView.swift
//  Shellder
//
//  Created by Drew Bonner on 11/13/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import CoreData

class ProgressView: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    
    var finished = 0.0
    var total = 0.0
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /*
    This value is either passed by `ActivityTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new activity.
    */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        //loadSavedActivities()
        //Progress.progress = Float(finished)/Float(total)
        
    }
    override func viewWillAppear(animated: Bool) {
        finished = 0
        total = 0
        loadSavedActivities()
        Progress.progress = Float(finished)/Float(total)
        Label.text = String(Progress.progress * 100) + "%"
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            confirmDelete()
        }
    }
    
    func cancelDeleteActivity(alertAction: UIAlertAction!) {
        
    }
    
    func handleDeleteProgress(alertAction: UIAlertAction!){
        // Create the fetch request
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        let idSort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSort]
        
        // Execute the fetch request on the context
        do {
            let savedActivities = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Activity]
            for activity in savedActivities {
                activity.complete = 0
            }
        } catch let error as NSError {
            print(error)
        }
        do {
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Failed to save the new progress. Error = \(error)")
        }
        
        Progress.progress = 0
        Label.text = String(0) + "%"
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Delete Progress", message: "Are you sure you want to permanently delete your Progress?", preferredStyle: .ActionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteProgress)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteActivity)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func loadSavedActivities() {
        // Create the fetch request
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        let idSort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSort]
        
        // Execute the fetch request on the context
        do {
            let savedActivities = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Activity]
            for activity in savedActivities {
                total++
                if (activity.complete == 1) {
                    finished++
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }

}

