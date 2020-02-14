//
//  ViewController.swift
//  Astralis
//
//  Created by Frederik Søndergaard Jensen on 14/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var rosterButton: UIButton!
    @IBOutlet weak var sponsorsButton: UIButton!
    @IBOutlet weak var achievementsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutButton.layer.cornerRadius = 4
        rosterButton.layer.cornerRadius = 4
        sponsorsButton.layer.cornerRadius = 4
        achievementsButton.layer.cornerRadius = 4
        
    }


}

