//
//  NewEntryViewController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewEntryViewController: UIViewController, CLLocationManagerDelegate {

    let locManager = CLLocationManager()

    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryTextBox: UITextView!
    @IBOutlet weak var entryLatitude: UITextField!
    @IBOutlet weak var entryLongitude: UITextField!
    
    @IBAction func saveButtonPressed(sender: AnyObject) {

        let tempCoordinate = CLLocationCoordinate2D(latitude: (entryLatitude.text! as NSString).doubleValue, longitude: (entryLongitude.text! as NSString).doubleValue)
        let newEntry = JournalEntry(title: entryTitle.text!, notes: entryTextBox.text!, date: "", coordinate: tempCoordinate)
        
        JournalEntryController.sharedInstance.addEntry(newEntry)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryTextBox!.layer.borderWidth = 1
        entryTextBox!.layer.borderColor = UIColor.blackColor().CGColor
        navigationItem.title = "New Entry"
        locManager.delegate = self
        locManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        entryLatitude.text = "\(newLocation.coordinate.latitude)"
        entryLongitude.text = "\(newLocation.coordinate.longitude)"
        locManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == .Denied {
            let alert = UIAlertController(title: "its ok", message: "we'll find you anyway", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else if status == .AuthorizedWhenInUse {
            locManager.startUpdatingLocation()
            return
        }
    }
}
