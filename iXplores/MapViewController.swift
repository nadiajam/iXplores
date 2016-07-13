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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalMap.delegate = self
        journalTable.dataSource = self
        journalTable.delegate = self
        locManager.delegate = self
        
        //creating initial map view
        let southAfrica = CLLocationCoordinate2D(latitude: -33.92486, longitude: 18.42405)
        let southAfricaSpan = MKCoordinateSpanMake(0.07, 0.07)
        let southAfricaRegion = MKCoordinateRegionMake(southAfrica, southAfricaSpan)
        
        journalMap.setRegion(southAfricaRegion, animated: true)
        
        //map view details
        journalMap.mapType = .Hybrid
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
        journalMap.addAnnotations(JournalEntryController.sharedInstance.updatedJournalEntryArray)
    }
    
    func newEntryPressed(sender:UIBarButtonItem){
        let viewController = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalEntryController.sharedInstance.updatedJournalEntryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(JournalEntryController.sharedInstance.updatedJournalEntryArray[indexPath.row].title!)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entryArray = JournalEntryController.sharedInstance.updatedJournalEntryArray
        
        let entrySpan = MKCoordinateSpanMake(0.02, 0.02)
        let entryRegion = MKCoordinateRegionMake(entryArray[indexPath.row].coordinate, entrySpan)
        
        journalMap.setRegion(entryRegion, animated: true)
        journalMap.selectAnnotation(JournalEntryController.sharedInstance.updatedJournalEntryArray[indexPath.row], animated: true)
    }
    
    //change pins and add callouts
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if (annotationView == nil){
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = UIColor.purpleColor()
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
}
