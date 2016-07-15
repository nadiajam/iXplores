//
//  JournalEntryController.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/11/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class JournalEntryController {
    static var sharedInstance = JournalEntryController()
    
    var addedEntry: Bool = false
    
    var journalEntryArray: [JournalEntry] = {
//        let j1 = JournalEntry(title:"Entry 1: Truth Coffee", notes:"hehe", date:"Jan 1st", image:"drake", coordinate: CLLocationCoordinate2D(latitude:-33.928190, longitude:18.422560))
//        let j2 = JournalEntry(title:"Entry 2: Gelato Mania", notes:"hehe", date:"Jan 2nd", coordinate: CLLocationCoordinate2D(latitude:-33.908484, longitude:18.411469))
//        let j3 = JournalEntry(title:"Entry 3: Old Bisquit Mill", notes:"hehe", date:"Jan 3rd", coordinate: CLLocationCoordinate2D(latitude:-33.927544, longitude:18.457082))
//        let j4 = JournalEntry(title:"Entry 4: Never@Home", notes:"hehe", date:"Jan 4th", coordinate: CLLocationCoordinate2D(latitude:-33.907731, longitude:18.409117))
//        let j5 = JournalEntry(title:"Entry 5: Workshop17", notes:"hehe", date:"Jan 5th", coordinate: CLLocationCoordinate2D(latitude:-33.906049, longitude:18.419418))
//        let j6 = JournalEntry(title:"Entry 6: Virgin Active", notes:"hehe", date:"Jan 6th", coordinate: CLLocationCoordinate2D(latitude:-33.905889, longitude:18.400540))
        return []
    }()
    
    
    func addEntry(journalEntry: JournalEntry) {
        journalEntryArray.append(journalEntry)
        addedEntry = true
        
        let manager = NSFileManager.defaultManager()
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documents.URLByAppendingPathComponent("journalEntries.txt")
        
        NSKeyedArchiver.archiveRootObject(journalEntry, toFile: fileURL.path!)
    }
    
    func lastJournalEntry() -> JournalEntry? {
        if !addedEntry {
            return nil
        }
        addedEntry = false
        return journalEntryArray.last!
    }
    
}

