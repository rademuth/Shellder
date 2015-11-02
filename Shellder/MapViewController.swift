//
//  MapViewController.swift
//  Shellder
//
//  Created by Robert Demuth on 10/20/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!

    var activity: Activity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.hidden = true
        mapView.hidden = false
        
        print("MapViewController: viewDidLoad()")
        
        if activity?.photo != nil {
            print("Found a saved image")
            imageView.image = UIImage(data: (activity?.photo)!)
        } else {
            print("Use the default photo")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        // Save the image to core data
        activity?.photo = UIImagePNGRepresentation(selectedImage)
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Failed to save the new photo. Error = \(error)")
        }
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func takePicture(sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be taken, not picked.
        imagePickerController.sourceType = .Camera
        // Only allow photos to be picked, not taken.
        //imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            imageView.hidden = true
            mapView.hidden = false
            break
        case 1:
            mapView.hidden = true
            imageView.hidden = false
            break
        default:
            break
        }
    }
    
    
}
