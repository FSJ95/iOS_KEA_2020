//
//  SponsorsViewController.swift
//  Astralis
//
//  Created by Frederik Søndergaard Jensen on 14/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class SponsorsViewController: UIViewController {

    @IBOutlet weak var sponsorsBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sponsorsBackButton.layer.cornerRadius = 4
    }
}
