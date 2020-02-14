//
//  AboutViewController.swift
//  Astralis
//
//  Created by Frederik Søndergaard Jensen on 14/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutBackgroundImage: UIImageView!
    @IBOutlet weak var aboutTitleLabel: UILabel!
    @IBOutlet weak var aboutDescriptionLabel: UILabel!
    @IBOutlet weak var aboutBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutBackButton.layer.cornerRadius = 4
    }

}
