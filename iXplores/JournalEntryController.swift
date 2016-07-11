//
//  JournalEntryController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import Foundation
import MapKit

class JournalEntryController: NSObject {
    static var sharedInstance = JournalEntryController()
    var currentJurnalEntry = JournalEntry?()
    var journalArray:[JournalEntry] = []
    let j1loc = CLLocationCoordinate2D(latitude:-22.3285, longitude:24.6849)
    let j2loc = CLLocationCoordinate2D(latitude:-25.9, longitude:32.6)
    let j3loc = CLLocationCoordinate2D(latitude:-29.6100, longitude:28.2336)
    let j4loc = CLLocationCoordinate2D(latitude:47.6062 , longitude:122.3321)
    let j5loc = CLLocationCoordinate2D(latitude:-33.9249, longitude:18.4241)
    let j6loc = CLLocationCoordinate2D(latitude:-22.9576, longitude:18.4904)
    let j7loc = CLLocationCoordinate2D(latitude:-25.7479, longitude:28.2293)
    
    let j1 = JournalEntry(title:"1", notes:"Botswana", date:"Jan 1st", location: JournalEntryController.sharedInstance.j1loc)
    let j2 = JournalEntry(title:"2", notes:"Mozambique", date:"Jan 2nd", location: JournalEntryController.sharedInstance.j2loc)
    let j3 = JournalEntry(title:"3", notes:"Lesotho", date:"Jan 3rd", location: JournalEntryController.sharedInstance.j3loc)
    let j4 = JournalEntry(title:"4", notes:"Seattle", date:"Jan 4th", location: JournalEntryController.sharedInstance.j4loc)
    let j5 = JournalEntry(title:"5", notes:"Cape Town", date:"Jan 5th", location: JournalEntryController.sharedInstance.j5loc)
    let j6 = JournalEntry(title:"6", notes:"Namibia", date:"Jan 6th", location: JournalEntryController.sharedInstance.j6loc)
    let j7 = JournalEntry(title:"7", notes:"Pretoria", date:"Jan 7th", location: JournalEntryController.sharedInstance.j7loc)
    
    
    func allJournalEntries() -> [JournalEntry] {
        return [j1, j2, j3, j4, j5, j6, j7]
    }
}

