//
//  File.swift
//  Shellder
//
//  Created by Robert Demuth on 10/20/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class OldActivity: NSObject, NSCoding {
    
    // MARK: Properties
    var id: Int
    var title: String
    var latitude: Float
    var longitude: Float
    var photo: UIImage?
    var complete: Bool
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("activities")
    
    // MARK: Types
    struct PropertyKey {
        static let idKey = "id"
        static let titleKey = "title"
        static let latitudeKey = "latitude"
        static let longitudeKey = "longitude"
        static let photoKey = "photo"
        static let completeKey = "complete"
    }
    
    init(id: Int, title: String, latitude: Float, longitude: Float, photo: UIImage?, complete: Bool) {
        self.id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.photo = photo
        self.complete = complete
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: PropertyKey.idKey)
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeFloat(latitude, forKey: PropertyKey.latitudeKey)
        aCoder.encodeFloat(longitude, forKey: PropertyKey.longitudeKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeBool(complete, forKey: PropertyKey.completeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey(PropertyKey.idKey)
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let latitude = aDecoder.decodeFloatForKey(PropertyKey.latitudeKey)
        let longitude = aDecoder.decodeFloatForKey(PropertyKey.longitudeKey)
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let complete = aDecoder.decodeBoolForKey(PropertyKey.completeKey)
        
        // Must call designated initilizer
        self.init(id: id, title: title, latitude: latitude, longitude: longitude, photo: photo, complete: complete)
    }
    
}
