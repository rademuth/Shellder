//
//  ActivityTableViewController.swift
//  Shellder
//
//  Created by Robert Demuth on 10/25/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {

    // MARK: Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var activities = [Activity]()
    var deleteActivityIndexPath: NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        // navigationItem.leftBarButtonItem = editButtonItem()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadSavedActivities()
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
                activities.append(activity)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Delete Activity", message: "Are you sure you want to permanently delete this activity?", preferredStyle: .ActionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteActivity)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteActivity)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteActivity(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteActivityIndexPath {
            // Delete the row from the data source
            managedObjectContext.deleteObject(activities[indexPath.row]) // Delete from core data
            activities.removeAtIndex(indexPath.row) // Delete from array
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) // Delete from table view
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Failed to delete the old activity. Error = \(error)")
            }
            crunchActivityIds()
        }
    }
    
    func cancelDeleteActivity(alertAction: UIAlertAction!) {
        deleteActivityIndexPath = nil
    }
    
    func crunchActivityIds() {
        //let nextIndexPath=NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section);
        if activities.count > 116 {
            for i in 116...activities.count-1 {
                activities[i].id = i+1
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Failed to delete the old activity. Error = \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ActivityTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ActivityTableViewCell

        // Fetches the appropriate meal for the data source layout.
        let activity = activities[indexPath.row]
        
        cell.idLabel.text = activity.id?.stringValue
        cell.titleLabel.text = activity.title
        
        cell.checkControl.checked = (activity.complete?.boolValue)!
        cell.checkControl.updateCheckboxSelectionState()
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return indexPath.row > 115
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteActivityIndexPath = indexPath
            confirmDelete()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            print("ActivityTableViewController --> MapViewController")
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let detailViewController = navigationViewController.viewControllers[0] as! DetailViewController

            // Get the cell that generated this segue.
            if let selectedActivityCell = sender as? ActivityTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedActivityCell)!
                let selectedActivity = activities[indexPath.row]
                // Set the activity in the MapViewController
                detailViewController.activity = selectedActivity
            }
        }
        else if segue.identifier == "AddItem" {
            print("ActivityTableViewController --> ActivityViewController")
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let activityViewController = navigationViewController.viewControllers[0] as! ActivityViewController
            
            // Set the size variable in the ActivityViewController
            activityViewController.size = activities.count
        }
    }
    
    @IBAction func unwindToActivityList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ActivityViewController, activity = sourceViewController.activity {
            print("ActivityViewController --> ActivityTableViewController")
            // Add a new activity.
            let newIndexPath = NSIndexPath(forRow: activities.count, inSection: 0)
            activities.append(activity)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        if let sourceViewController = sender.sourceViewController as? DetailViewController, activity = sourceViewController.activity {
            print("MapViewController --> ActivityTableViewController")
            print("  - Complete: " + (activity.complete?.stringValue)!)
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                activities[selectedIndexPath.row] = activity
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }

}
