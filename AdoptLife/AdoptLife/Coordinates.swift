//
//  Coordinates.swift
//  AdoptLife
//
//  Created by MacStudent on 2017-11-10.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation
import CoreLocation

class Coordinates  {
    let geocoder = CLGeocoder()
    
    func AdressToLatitude(addressP: String, completion: @escaping (Bool, CLLocationCoordinate2D?)-> () ) {
        geocoder.geocodeAddressString(addressP) {(placemarks , error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                //self.latitude = "\(coordinates.latitude)"
                
                completion(true, coordinates)
            }
        }
    }
    /*func AdressToLongitude(_ addressP: String, completion: @escaping (_ string: String)->()) {
        geocoder.geocodeAddressString(addressP, completionHandler: {(placemarks , error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.longitude = "\(coordinates.longitude)"
                
                completion(self.longitude)
            }
        })
    }*/
}
