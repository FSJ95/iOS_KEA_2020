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
        let pizzaMark = createMarker(title: "Parmas Pizza", lan: 55.654393, lon: 12.4737828)
        map.addAnnotation(pizzaMark)
        let venueMark = createMarker(title: "Royal Arena", lan: 55.6254401, lon: 12.5715215)
        map.addAnnotation(venueMark)
        
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: sender.view)
        
        print(location)
    }
    
    func createMarker(title: String, lan: CLLocationDegrees, lon: CLLocationDegrees) -> MKPointAnnotation {
        let marker = MKPointAnnotation() // Initialize empty marker.
        marker.title = title // Message on the marker.
        let location = CLLocationCoordinate2DMake(lan, lon) // Initializing the marker.
        marker.coordinate = location // Add location to the marker.
        return marker
    }
}

