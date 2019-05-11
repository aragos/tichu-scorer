//
//  GameState.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/10/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import Foundation

class GameState {
    let players: [Position: Player]
    var calls: [Position: Call] = [:]
    var completedHands: [Hand] = []
    
    var eastWestScore: Int {
        get {
            var total = 0
            for hand in completedHands {
                total += hand.eastWestScore
            }
            return total
        }
    }
    
    var northSouthScore: Int {
        get {
            var total = 0
            for hand in completedHands {
                total += hand.northSouthScore
            }
            return total
        }
    }
    
    init(east: Player, west: Player, north: Player, south: Player, hands: [Hand]? = nil) {
        players = [
            .east: east,
            .west: west,
            .north: north,
            .south: south
        ]
        resetCalls()
        if let hands = hands {
            completedHands = hands
        }
    }
    
    func recordHand(hand: Hand) {
        completedHands.append(hand)
        resetCalls()
    }
    
    private func resetCalls() {
        for position in Position.allCases {
            calls[position] = .none
        }
    }
}
