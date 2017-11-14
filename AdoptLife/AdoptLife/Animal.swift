//
//  Animal.swift
//  AdoptLife
//
//  Created by MacStudent on 2017-11-03.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit

class Animal {
    //MARK: Properties
    public private(set) var image: UIImage!
    public private(set) var type: String
    public private(set) var age: String
    public private(set) var size: String
    public private(set) var gender: String
    public private(set) var owner: Person
    
    init(image: UIImage, type: String, age: String, size: String, gender: String, owner: Person) {
        self.image = image
        self.type = type
        self.age = age
        self.size = size
        self.gender = gender
        self.owner = owner
    }
    
    public func setImage(image: UIImage!) {
        self.image = image
    }
    public func setType(type: String) {
        self.type = type
    }
    public func setAge(age: String) {
        self.age = age
    }
    public func setSize(size: String) {
        self.size = size
    }
    public func setGender(gender: String) {
        self.gender = gender
    }
    public func setPerson(owner: Person) {
        self.owner = owner
    }

}
