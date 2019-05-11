//
//  Hand.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/10/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import Foundation

struct Hand {
    let eastWestScore: Int
    let northSouthScore: Int
    let firstOut: Position
    let calls: [Position: Call]
}
