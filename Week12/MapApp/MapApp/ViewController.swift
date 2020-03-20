//
//  ViewController.swift
//  MapApp
//
//  Created by Frederik Søndergaard Jensen on 20/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet var longPressedLocation: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding some random locations to the map
        createMarker(title: "Parmas Pizza", lan: 55.654393, lon: 12.4737828)
        createMarker(title: "Royal Arena", lan: 55.6254401, lon: 12.5715215)
        
        // How long a longpress is?
        longPressedLocation.minimumPressDuration = 0.5
        
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        // Get the location of the longpress.
        let touchPoint = longPressedLocation.location(in: self.map)
        let location = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
        // Start the Alert to get the location name (We are sending location since
        // alerts work async, and we need the title before we create the point)
        showTitleAlert(location: location)
    }
    
    // Show the alert prompt to add a title
    func showTitleAlert(location: CLLocationCoordinate2D) {
        var titleTextField: UITextField?
        var alertController: UIAlertController!
        
        // Creating the AlertController
        alertController = UIAlertController(title: "Map", message:
            "Please add a title to the location", preferredStyle: .alert)
        
        // Creating the save button and creates the marker when pressed.
        let locationTitle = UIAlertAction(title: "Save", style: .cancel) { (save) in
            if let title = titleTextField?.text {
                self.createMarker(title: title, lan: location.latitude, lon: location.longitude)
            }
        }
        
        // Create and adds the texfield to the AlertController
        alertController.addTextField { (titleField) in
            titleTextField = titleField
            titleTextField?.placeholder = "Enter title"
        }
        
        // Adds the save button to the AlertController
        alertController.addAction(locationTitle)
        
        // Present the AlertController to the user
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // Function for creating a marker and adding it to the map
    func createMarker(title: String, lan: CLLocationDegrees, lon: CLLocationDegrees){
        let marker = MKPointAnnotation() // Initialize empty marker.
        marker.title = title // Message on the marker.
        let location = CLLocationCoordinate2DMake(lan, lon) // Initializing the marker.
        marker.coordinate = location // Add location to the marker.
        map.addAnnotation(marker) // Add marker to the map
    }
}

