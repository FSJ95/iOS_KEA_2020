//
//  noteModel.swift
//  PictureSaver
//
//  Created by Frederik Søndergaard Jensen on 17/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import Foundation
import UIKit

struct NoteModel {
    
    let title: String!
    let body: String!
    let imageName: String!
    let time: NSNumber!
    
    init(title: String, body: String, imageName: String, time: NSNumber) {
        self.title = title
        self.body = body
        self.imageName = imageName
        self.time = time
    }
    
}
