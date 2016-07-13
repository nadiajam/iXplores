//
//  JournalEntry.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class JournalEntry: NSObject, NSCoding, MKAnnotation {
    var title:String?
    var notes:String?
    var date:String? //NSDate //CLLocationCoordinate2D.timestamp
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:0, longitude:0) //CLLocationCoordinate2D
    
    init (title:String, notes:String, date:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.notes = notes
        self.date = date
        self.coordinate = coordinate
    }
    required init?(coder: NSCoder) {
        //
    }
    func encodeWithCoder(aCoder: NSCoder) {
        //
    }
}