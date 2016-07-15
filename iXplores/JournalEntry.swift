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

class JournalEntry: NSObject, MKAnnotation, NSCoding {
    var title:String?
    var notes:String?
    var date:NSDate
//    var image:UIImage?
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:0, longitude:0)
    
    init (title:String, notes:String, date:NSDate, coordinate:CLLocationCoordinate2D) {  //image:UIImage
        self.title = title
        self.notes = notes
        self.date = date
//        self.image = image
        self.coordinate = coordinate
    }
    
    required init?(coder: NSCoder) {
        title = (coder.decodeObjectForKey("title") as? String) ?? ""
        notes = (coder.decodeObjectForKey("notes") as? String) ?? ""
        date = (coder.decodeObjectForKey("date") as? NSDate)!
//        image = (coder.decodeObjectForKey("image") as? UIImage)
        coordinate.latitude = (coder.decodeObjectForKey("latitude") as? CLLocationDegrees) ?? 0
        coordinate.longitude = (coder.decodeObjectForKey("longitude") as? CLLocationDegrees) ?? 0
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(title, forKey: "title")
        coder.encodeObject(notes, forKey: "notes")
        coder.encodeObject(date, forKey: "date")
//        coder.encodeObject(image, forKey: "image")
        coder.encodeObject(coordinate.latitude, forKey: "latitude")
        coder.encodeObject(coordinate.longitude, forKey: "longitude")
    }
}