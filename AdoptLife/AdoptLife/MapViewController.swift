//
//  MapViewController.swift
//  AdoptLife
//
//  Created by Macstudent on 2017-11-03.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
import MapKit
import CoreFoundation

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var newAnimal: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadData()
        
        if (newAnimal != nil) {
            data.append(newAnimal!)
        }
        
        for a in data {
            let point = AnimalAnnotation(coordinate: CLLocationCoordinate2D(latitude: a.owner.latitude , longitude: a.owner.longitude))
            point.image = a.image
            point.type = a.type
            point.size = a.size
            point.gender = a.gender
            point.age = a.age
            point.name = a.owner.name
            point.address = a.owner.address
            point.phone = a.owner.phone
            point.email = a.owner.email
            self.mapView.addAnnotation(point)
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.644929, longitude: -79.408411), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
        self.mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        let animalAnnotation = view.annotation as! AnimalAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.animalType.text = animalAnnotation.type
        calloutView.animalSize.text = animalAnnotation.size
        calloutView.animalGender.text = animalAnnotation.gender
        calloutView.animalAge.text = animalAnnotation.age
        calloutView.personName.text = animalAnnotation.name
        calloutView.personAddress.text = animalAnnotation.address
        calloutView.personPhone.text = animalAnnotation.phone
        calloutView.personEmail.text = animalAnnotation.email
        calloutView.animalImage.image = animalAnnotation.image

        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var data: [Animal] = []
    func loadData(){
        let person1 = Person(name: "Thomas Roy", address: "34 Van Horne Avenue, Toronto", latitude: 43.784582, longitude: -79.363326, phone: "6478058776", email: "thomasR@gmail.com")
        let person2 = Person(name: "William Tremblay", address: "12 Wanless Avenue, Toronto", latitude: 43.726739, longitude: -79.402016, phone: "6476789904", email: "williamT@gmail.com")
        let person3 = Person(name: "Olivia Brown", address: "58 Coney Road, Toronto", latitude: 43.632901, longitude: -79.511743, phone: "6471179679", email: "oliviaB@gmail.com")
        let person4 = Person(name: "Megan Smith", address: "63 Ashford Drive, Toronto", latitude: 43.672844, longitude: -79.551273, phone: "6472344678", email: "meganS@gmail.com")
        let person5 = Person(name: "Rebecca Lee", address: "29 Olive Ave, Toronto", latitude: 43.669906, longitude: -79.414651, phone: "6476564221", email: "RebeccaL@gmail.com")
        let person6 = Person(name: "Samuel Bouchard", address: "19 Antony Road, Toronto", latitude: 43.730621, longitude: -79.459955, phone: "6475475190", email: "samuelB@gmail.com")
        let person7 = Person(name: "Julie Wilson", address: "247 Mutual Street, Toronto", latitude: 43.662334, longitude: -79.377658, phone: "6476848161", email: "julieW@gmail.com")
        let person8 = Person(name: "Logan Gagnon", address: "76 Mitchell Avenue, Toronto", latitude: 43.644929, longitude: -79.408411, phone: "6479889466", email: "loganG@gmail.com")
        
        let imgAnimal1 = UIImage(named: "cat1")
        let imgAnimal2 = UIImage(named: "cat2")
        let imgAnimal3 = UIImage(named: "cat3")
        let imgAnimal4 = UIImage(named: "cat4")
        let imgAnimal5 = UIImage(named: "dog1")
        let imgAnimal6 = UIImage(named: "dog2")
        let imgAnimal7 = UIImage(named: "dog3")
        let imgAnimal8 = UIImage(named: "dog4")
        
        let animal1 = Animal(image: imgAnimal1!, type: "Cat", age: "1 year", size: "Small", gender: "Female", owner: person1)
        let animal2 = Animal(image: imgAnimal2!, type: "Cat", age: "5 years", size: "Medium", gender: "Female", owner: person2)
        let animal3 = Animal(image: imgAnimal3!, type: "Cat", age: "4 months", size: "Small", gender: "Male", owner: person3)
        let animal4 = Animal(image: imgAnimal4!, type: "Cat", age: "7 years", size: "Big", gender: "Female", owner: person4)
        let animal5 = Animal(image: imgAnimal5!, type: "Dog", age: "6 years", size: "Medium", gender: "Male", owner: person5)
        let animal6 = Animal(image: imgAnimal6!, type: "Dog", age: "7 years", size: "Big", gender: "Female", owner: person6)
        let animal7 = Animal(image: imgAnimal7!, type: "Dog", age: "7 years", size: "Medium", gender: "Male", owner: person7)
        let animal8 = Animal(image: imgAnimal8!, type: "Dog", age: "6 months", size: "Small", gender: "Male", owner: person8)

        data.append(animal1)
        data.append(animal2)
        data.append(animal3)
        data.append(animal4)
        data.append(animal5)
        data.append(animal6)
        data.append(animal7)
        data.append(animal8)
    }

}
