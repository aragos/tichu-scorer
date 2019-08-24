//
//  MenuViewController.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/11/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var currentGameButton: UIButton!
    
    var gameStateController: GameStateController?
    var playerController: PlayerController?
    
    override func viewWillAppear(_ animated: Bool) {
        currentGameButton.isEnabled = getCurrentGame() != nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newGameController = segue.destination as? NewGameViewController {
            newGameController.gameStateController = gameStateController
            newGameController.playerController = playerController
        }
        
        if let scoreViewController = segue.destination as? ScoreViewController {
            scoreViewController.gameStateController = gameStateController
        }
        
        // TODO: Add passing on of data for other child controllers
    }
    
    @IBAction func newGame(_ sender: Any) {
        if (getCurrentGame() != nil) {
            let alert = UIAlertController(title: "Game in progress", message: "Do you want to abort the current game?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Nevermind", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Create new game", style: .destructive, handler: {
                _ in self.performSegue(withIdentifier: "ShowNewGameSegue", sender: self)
            }))
        } else {
            self.performSegue(withIdentifier: "ShowNewGameSegue", sender: self)
        }
    }
    
    private func getCurrentGame() -> GameState? {
        guard let gameStateController = gameStateController else {
            fatalError("Cannot use menu without game state")
        }
        
        return gameStateController.currentGame
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
