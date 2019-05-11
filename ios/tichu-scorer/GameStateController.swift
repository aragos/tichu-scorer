//
//  GameStateController.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/10/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import Foundation

class GameStateController {
    
    var currentGame: GameState?
    
    init() {
        // TODO: Load current game from disk
        
        currentGame = GameState(east: Player(id: 0, name: "Peter"), west: Player(id: 1, name: "Adam"), north: Player(id: 2, name: "Ien"), south: Player(id: 3, name: "Jen"))        
    }
    
    func recordHand(hand: Hand) {
        guard let game = currentGame else {
            fatalError("Can't record hand if there is no game!")
        }
        
        // TODO: Save hand to db
        
        game.recordHand(hand: hand)
    }
    
}
