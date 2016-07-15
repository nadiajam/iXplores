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

    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryTextBox: UITextView!
    @IBOutlet weak var entryLatitude: UITextField!
    @IBOutlet weak var entryLongitude: UITextField!
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    //date picker
    @IBAction func datePicker(sender: UITextField) {
        var datePickerView: UIDatePicker = UIDatePicker()       //initilalizing
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.stringFromDate(NSDate())
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    let locManager = CLLocationManager()
    let now = NSDate()
    
    @IBAction func saveButtonPressed(sender: AnyObject) {

        //retreiving information from input
        let tempCoordinate = CLLocationCoordinate2D(latitude: (entryLatitude.text! as NSString).doubleValue, longitude: (entryLongitude.text! as NSString).doubleValue)
        let newEntry = JournalEntry(title: entryTitle.text!, notes: entryTextBox.text!, date: now, coordinate: tempCoordinate)
        
        //adding it to tableView
        JournalEntryController.sharedInstance.addEntry(newEntry)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Entry"
        
        locManager.delegate = self
        locManager.startUpdatingLocation()
        
        entryTextBox.layer.borderColor = UIColor(red:229/255, green: 229/255, blue:229/255, alpha:1).CGColor
        entryTextBox.layer.cornerRadius = 5
        
        saveButton.layer.backgroundColor = UIColor(red:23/255, green:23/255, blue:45/255, alpha: 1).CGColor
        saveButton.layer.cornerRadius = 5
        
        entryImage.layer.cornerRadius = 5
        
        let background = CAGradientLayer().gradientBackground()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        entryLatitude.text = "\(newLocation.coordinate.latitude)"
        entryLongitude.text = "\(newLocation.coordinate.longitude)"
        locManager.stopUpdatingLocation()
    }
}
