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
import CoreLocation

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Properties
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkControl: CheckControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    var activity: Activity? = nil
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.hidden = true
        mapView.hidden = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        idLabel.text = activity?.id?.stringValue
        titleLabel.text = activity?.title
        checkControl.checked = (activity?.complete?.boolValue)!
        
        if activity?.photo != nil {
            imageView.image = UIImage(data: (activity?.photo)!)
        } else {
            
        }
        
        if activity?.latitude?.doubleValue != 0 && activity?.longitude?.doubleValue != 0 {
            let annotation = Annotation(coordinate: CLLocationCoordinate2D(latitude: (activity?.latitude?.doubleValue)!, longitude: (activity?.longitude?.doubleValue)!))
            mapView.addAnnotation(annotation)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

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
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            // Save the image
            activity?.photo = UIImagePNGRepresentation(imageView.image!)
            
            // Save the state of the checkbox
            activity?.complete = checkControl.checked
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Failed to save the new photo. Error = \(error)")
            }
        }
    }
    
}
