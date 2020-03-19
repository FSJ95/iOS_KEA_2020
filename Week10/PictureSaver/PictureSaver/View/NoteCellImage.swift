//
//  NoteCell.swift
//  PictureSaver
//
//  Created by Frederik Søndergaard Jensen on 16/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class NoteCellImage: UITableViewCell {
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
