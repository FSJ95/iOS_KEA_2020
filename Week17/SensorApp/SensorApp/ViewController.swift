//
//  ViewController.swift
//  SensorApp
//
//  Created by Frederik Søndergaard Jensen on 24/04/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var paceLabel: UILabel!
    let pedoMeter = CMPedometer() // Step detector
    
    var isStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        stepsLabel.text = "Steps: 0"
        distanceLabel.text = "Distance: 0"
        paceLabel.text = "Pace: 0"
        StartStopButton.backgroundColor = #colorLiteral(red: 0.1320809424, green: 0.3720289469, blue: 1, alpha: 1)
        StartStopButton.setTitle("START TRACKING", for: .normal)
        
    }

    @IBAction func startTrackingPressed(_ sender: Any) {
        
        if isStarted {
            StartStopButton.backgroundColor = #colorLiteral(red: 0.1320809424, green: 0.3720289469, blue: 1, alpha: 1)
            StartStopButton.setTitle("START TRACKING", for: .normal)
            isStarted = false
            pedoMeter.stopUpdates()
        } else {
            StartStopButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            StartStopButton.setTitle("STOP TRACKING", for: .normal)
        
            isStarted = true
            pedoMeter.startUpdates(from: Date()) { (data, error) in
                DispatchQueue.main.async {
                    self.stepsLabel.text = "Steps: \(data?.numberOfSteps ?? 0.0)"
                    self.distanceLabel.text = "Distance: \(data?.distance?.intValue ?? 0) m"
                    self.paceLabel.text = "Pace: \(((data?.currentPace?.doubleValue ?? 0.0) * 3.6).rounded()) km/t"
                }
            }
        }
    }
}

