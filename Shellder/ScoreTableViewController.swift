//
//  ScoreTableViewController.swift
//  Shellder
//
//  Created by Robert Demuth on 11/18/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {

    // MARK: Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var scores = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadSavedScores()
    }
    
    func loadSavedScores() {
        
        let postEndpoint: String = "https://serene-eyrie-6791.herokuapp.com/app/view/"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            
            // Do stuff with the response here
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /view/")
                print(error)
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            let online_scores: [NSDictionary]
            do {
                online_scores = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! [NSDictionary]
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            // now we have the scores, let's just print them to prove we can access it
            print("The scores are: " + online_scores.description)
            
            // the post object is an array of dictionaries
            for online_score in online_scores {
                if let fields = online_score["fields"] as? NSDictionary {
                    if let name = fields["name"] as? String {
                        if let completed = fields["completed"] as? Int {
                            print("Name: " + name)
                            print("Completed: " + String(completed))
                            self.scores.append(Score(name: name, completed: completed))
                        }
                    }
                }
            }
            
            // Reload the table view when the data has finished downloading
            self.scores.sortInPlace({ $0.completed > $1.completed })
            self.tableView.reloadData()
            
        })
        task.resume()
        
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
        return scores.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ScoreTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ScoreTableViewCell
    
        // Fetches the appropriate meal for the data source layout.
        let score = scores[indexPath.row]
    
        cell.nameLabel.text = score.name
        cell.progressLabel.text = String(score.completed)
    
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "AddItem" {
            // Handle uploading a new score
        }
    }

}
