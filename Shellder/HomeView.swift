//
//  ProgressView.swift
//  Shellder
//
//  Created by Drew Bonner on 11/13/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import CoreData

class HomeView: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    
    var finished = 0
    var total = 0
    
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
        //Label.text = NSString(format: "Progress %.2f%%", Progress.progress * 100) as String
        Label.text = "Completed " + String(finished) + " of " + String(total) + " Activities"
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
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            confirmDelete()
        }
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Reset Progress", message: "Are you sure you want to permanently reset your progress? This will also remove all saved photos from the application.", preferredStyle: .ActionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteProgress)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteActivity)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteProgress(alertAction: UIAlertAction!){
        // Create the fetch request
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        let idSort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSort]
        
        var total = 0
        
        // Execute the fetch request on the context
        do {
            let savedActivities = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Activity]
            for activity in savedActivities {
                total++
                activity.complete = 0
                
                // Delete the photo
                activity.photo = nil
                
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
        Label.text = "Completed 0 of " + String(total) +  " Activities"
    }
    
    func cancelDeleteActivity(alertAction: UIAlertAction!) {
        
    }

}

