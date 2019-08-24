//
//  PlayerCell.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/14/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    
    var playerName: String? {
        didSet {
            playerNameLabel.text = playerName
        }
    }
}
