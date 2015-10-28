//
//  Activity+CoreDataProperties.swift
//  Shellder
//
//  Created by Robert Demuth on 10/28/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Activity {

    @NSManaged var id: NSNumber?
    @NSManaged var title: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var photo: NSData?
    @NSManaged var complete: NSNumber?

}
