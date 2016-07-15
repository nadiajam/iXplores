//
//  MapViewController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var journalMap: MKMapView!
    @IBOutlet weak var journalTable: UITableView!
    
    let locManager = CLLocationManager()
    let now = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:23/255, green:23/255, blue:45/255, alpha: 1)
        navigationItem.title = "iXplore"
        
        locManager.delegate = self
        journalMap.delegate = self
        journalTable.dataSource = self
        journalTable.delegate = self
        
        //connecting custom cell with table
        journalTable.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellOne")
        
        //creating initial map view
        let southAfrica = CLLocationCoordinate2D(latitude: -33.92486, longitude: 18.42405)
        let southAfricaSpan = MKCoordinateSpanMake(0.07, 0.07)
        let southAfricaRegion = MKCoordinateRegionMake(southAfrica, southAfricaSpan)
        
        journalMap.setRegion(southAfricaRegion, animated: true)
        
        //map view details
//        journalMap.mapType = .Hybrid
        journalMap.zoomEnabled = true
        journalMap.scrollEnabled = true
        
        //navigation bar details
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.newEntryPressed(_:)))
        navigationItem.setRightBarButtonItem(addButton, animated: true)
        
        //location preferences
        locManager.requestWhenInUseAuthorization()
        
        locManager.desiredAccuracy = 10
        locManager.distanceFilter = 10
        //locManager.startUpdatingLocation()
        
        journalMap.showsUserLocation = true
        
        updateUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        journalMap.addAnnotations(JournalEntryController.sharedInstance.journalEntryArray)
        updateUI()
    }
    
    func newEntryPressed(sender:UIBarButtonItem){
        
        let viewController = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalEntryController.sharedInstance.journalEntryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCellOne", forIndexPath: indexPath) as! CustomTableViewCell
        cell.customImage.image = UIImage(named: "drake")
        
        //setting the date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        cell.customDate.text = formatter.stringFromDate(now)
        
        //setting the title
        cell.customTitle.text = "\(JournalEntryController.sharedInstance.journalEntryArray[indexPath.row].title!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entryArray = JournalEntryController.sharedInstance.journalEntryArray
        
        let entrySpan = MKCoordinateSpanMake(0.02, 0.02)
        let entryRegion = MKCoordinateRegionMake(entryArray[indexPath.row].coordinate, entrySpan)
        
        journalMap.setRegion(entryRegion, animated: true)
        journalMap.selectAnnotation(JournalEntryController.sharedInstance.journalEntryArray[indexPath.row], animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    //change pins and add callouts
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if (annotationView == nil){
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = UIColor(red:189/255, green:11/255, blue:70/255, alpha: 1)
            annotationView!.canShowCallout = true
        }
        annotationView!.annotation = annotation
        return annotationView
    }

    func updateUI() {
        journalTable.reloadData()       //looks in the table view functions
        
        //visually adding annotations
        if let e = JournalEntryController.sharedInstance.lastJournalEntry() {
            journalMap.addAnnotation(e)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == .AuthorizedWhenInUse {
            locManager.startUpdatingLocation()
        }
        else if status == .Denied {
            let alert = UIAlertController(title: "its ok", message: "we'll find you anyway", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
