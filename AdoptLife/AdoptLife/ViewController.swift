//
//  ViewController.swift
//  AdoptLife
//
//  Created by MacStudent on 2017-11-03.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AKRadioButtonsControllerDelegate {
    
    func selectedButton(sender: AKRadioButton) {
        return ()
    }
    
    var typeRadioController: AKRadioButtonsController!
    var sizeRadioController: AKRadioButtonsController!
    var genderRadioController: AKRadioButtonsController!
    
    @IBOutlet var typeRadio: [AKRadioButton]!
    @IBOutlet var sizeRadio: [AKRadioButton]!
    @IBOutlet var genderRadio: [AKRadioButton]!
    
    @IBOutlet weak var imgAnimal: UIImageView!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var person: Person?
    var animal: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.delegate = self
        name.delegate = self
        address.delegate = self
        phone.delegate = self
        email.delegate = self
        
        typeRadioController = AKRadioButtonsController(radioButtons: self.typeRadio)
        typeRadioController.delegate = self
        sizeRadioController = AKRadioButtonsController(radioButtons: self.sizeRadio)
        sizeRadioController.delegate = self
        genderRadioController = AKRadioButtonsController(radioButtons: self.genderRadio)
        genderRadioController.delegate = self
        
        updateSaveButtonState()
    }
    
    //MARK: Text Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()

        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Image View Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Takes the original image
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //Set photoImageView to display the selected image
            imgAnimal.image = selectedImage
            //Dismiss the picker
            dismiss(animated: true, completion: nil)
            
        } else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let addressP = address.text!
        let geocoder = CLGeocoder()
        /*var latitudeP: Double  = 0.0
        var longitudeP: Double = 0.0
        var coordinatesP: CLLocationCoordinate2D!
        
        let coordinates = Coordinates()
        coordinates.AdressToLatitude(addressP: addressP, completion:  {
            success, coordinates in
            
            if success {
                print("success")
                print(coordinates ?? "")
                coordinatesP = coordinates
                latitudeP = Double((coordinates?.latitude)!)
                longitudeP = Double((coordinates?.longitude)!)
            }
            else {
                
            }
    
        })*/
        
        
        geocoder.geocodeAddressString(addressP, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("LatDoGeoCOde: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                
            }

        })

        
        //Configure the destination view controller only when the save button is pressed
        if segue.identifier == "saveAnimal" {
            var typeA = "Dog"
            var genderA = "Male"
            var sizeA = "Small"
            
            if (typeRadioController.selectedIndex == 1) {
                typeA = "Cat"
            }
            if (genderRadioController.selectedIndex == 1) {
                genderA = "Female"
            }
            if (sizeRadioController.selectedIndex == 1) {
                sizeA = "Medium"
            } else if (sizeRadioController.selectedIndex == 2) {
                sizeA = "Big"
            }
            
                //retrieving the screen data
                let nameP = name.text!
                let phoneP = phone.text!
                let emailP = email.text!
                let imageAnimal = imgAnimal.image!
                let ageA = age.text!

                if (!(nameP.isEmpty)) {
                    person = Person(name: nameP, address: addressP, latitude: 43.697501706742, longitude: -79.3402868913888, phone: phoneP, email: emailP)
                    animal = Animal(image: imageAnimal, type: typeA, age: ageA, size: sizeA, gender: genderA, owner: person!)

                } else {
                    //print the message on debug log
                    os_log("House do not have a address", log: OSLog.default, type: .debug)
                }
            
            let nextScene = segue.destination as! MapViewController
                nextScene.newAnimal = animal
            }
        
        }
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        //Disable the save button if the view is not totally completed
        let textPhone = phone.text
        let textEmail = email.text
        if let text = name.text {
            saveButton.isEnabled = !text.isEmpty
        }
        if let text = address.text {
            saveButton.isEnabled = !text.isEmpty
        }
        if (textPhone?.isEmpty)! && (textEmail?.isEmpty)! {
            saveButton.isEnabled = false
        }
    }
}

