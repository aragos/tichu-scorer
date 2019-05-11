//
//  ScoreViewController.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/9/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var eastScoreView: PlayerScoreView!
    @IBOutlet weak var westScoreView: PlayerScoreView!
    @IBOutlet weak var northScoreView: PlayerScoreView!
    @IBOutlet weak var southScoreView: PlayerScoreView!
    @IBOutlet weak var eastWestScore: UILabel!
    @IBOutlet weak var northSouthScore: UILabel!
    
    var scoreViewsByPosition: [Position: PlayerScoreView] {
        get {
            return [
                .east: eastScoreView,
                .west: westScoreView,
                .north: northScoreView,
                .south: southScoreView
            ]
        }
    }
    
    var gameStateController: GameStateController?
    
    override func viewDidLoad() {
        guard let gameState = gameStateController?.currentGame else {
            fatalError("Game state must be set to load game view")
        }
        
        super.viewDidLoad()
        
        for position in Position.allCases {
            refreshPositionView(position: position, gameState: gameState)
        }
        
        eastWestScore.text = String(gameState.eastWestScore)
        northSouthScore.text = String(gameState.northSouthScore)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let gameState = gameStateController?.currentGame else {
            fatalError("Game state must be set to load game view")
        }
        for position in Position.allCases {
            refreshPositionView(position: position, gameState: gameState)
        }
        
        eastWestScore.text = String(gameState.eastWestScore)
        northSouthScore.text = String(gameState.northSouthScore)
    }
    
    private func refreshPositionView(position: Position, gameState: GameState) {
        guard let scoreView = scoreViewsByPosition[position] else {
            fatalError("Score view should be present for all positions")
        }
        
        scoreView.setPlayerName(name: gameState.players[position]!.name)
        
        if let call = gameState.calls[position] {
            scoreView.setCall(call: call)
        } else {
            scoreView.setCall(call: .none)
        }
    }

    //MARK: Actions
    @IBAction func scoreHand(_ sender: UIButton) {
        guard let gameState = gameStateController?.currentGame else {
            fatalError("Game state must be set to operate in game view")
        }
        
        for position in Position.allCases {
            gameState.calls[position] = scoreViewsByPosition[position]!.getCall()
        }
        let scoreHandViewController = ScoreHandViewController(gameStateController: gameStateController!)
        navigationController?.pushViewController(scoreHandViewController, animated: true)
    }
}
