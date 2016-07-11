//
//  MapViewController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MAP
        //mapView.frame = CGRectMake(0, 0, mapView.frame.size.width-5, mapView.frame.size.height-5)
        //view.addSubview(mapView)
        
        let southAfrica = CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241)
        let span = MKCoordinateSpanMake(2000, 2000)
        let region = MKCoordinateRegion(center: southAfrica, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        //        mapView.addAnnotations(JournalEntryController.sharedInstance.allJournalEntries())
        
        mapView.mapType = .Hybrid
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        
        
        //TABLE
        
        
        //        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //            return 1
        //        }
        //        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //            return 5
        //        }
        //        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        //        }
        //        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //            print("row selected")
        //        }
        
        //PINPOINTS
        //        mapView.addAnnotation(JournalEntryController.sharedInstance.allJournalEntries())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
