//
//  AnimalAnnotation.swift
//  AdoptLife
//
//  Created by MacStudent on 2017-11-08.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import MapKit

class AnimalAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var image: UIImage!
    var type: String!
    var size: String!
    var gender: String!
    var age: String!
    var name: String!
    var address: String!
    var phone: String!
    var email: String!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
