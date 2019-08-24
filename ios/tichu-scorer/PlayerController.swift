//
//  PlayerController.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/11/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import Foundation

class PlayerController {
    var players: [Player]
    private var nextPlayerId: Int
    
    init() {
        players = []
        nextPlayerId = 0
        
        // TODO: load players from DB
    }
    
    func addPlayer(name: String) {
        // TODO: create player via DB
        let player = Player(id: nextPlayerId, name: name)
        
        players.append(player)
    }
}
