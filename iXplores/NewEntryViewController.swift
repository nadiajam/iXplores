//
//  NewEntryViewController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit
import MapKit

class NewEntryViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
