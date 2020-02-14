//
//  RosterViewController.swift
//  Astralis
//
//  Created by Frederik Søndergaard Jensen on 14/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class RosterViewController: UIViewController {
    @IBOutlet weak var rosterBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rosterBackButton.layer.cornerRadius = 4
    }

}
