//
//  Person.swift
//  AdoptLife
//
//  Created by MacStudent on 2017-11-03.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit

class Person {
    //MARK: Properties
    public private(set) var name: String
    public private(set) var address: String
    public private(set) var latitude: Double
    public private(set) var longitude: Double
    public private(set) var phone: String
    public private(set) var email: String
    
    init(name: String, address: String, latitude: Double, longitude: Double, phone: String, email: String) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.email = email
    }
    
    public func setName(name: String) {
        self.name = name
    }
    public func setAddress(address: String) {
        self.address = address
    }
    public func setLatitude(latitude: Double) {
        self.latitude = latitude
    }
    public func setLongitude(longitude: Double) {
        self.longitude = longitude
    }
    public func setPhone(phone: String) {
        self.name = phone
    }
    public func setEmail(email: String) {
        self.email = email
    }
}
