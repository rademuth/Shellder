//
//  File.swift
//  Shellder
//
//  Created by Robert Demuth on 11/3/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
        
}