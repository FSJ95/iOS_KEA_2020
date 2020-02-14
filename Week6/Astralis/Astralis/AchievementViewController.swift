//
//  AchievementViewController.swift
//  Astralis
//
//  Created by Frederik Søndergaard Jensen on 14/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {

    @IBOutlet weak var achievementBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        achievementBackButton.layer.cornerRadius = 4
    }

}
