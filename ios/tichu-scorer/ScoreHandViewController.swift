//
//  ScoreHandViewController.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/10/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit

class ScoreHandViewController: UIViewController {

    @IBOutlet weak var firstOutPicker: UIPickerView!
    @IBOutlet weak var eastPlayerLabel: UILabel!
    @IBOutlet weak var westPlayerLabel: UILabel!
    @IBOutlet weak var northPlayerLabel: UILabel!
    @IBOutlet weak var southPlayerLabel: UILabel!
    @IBOutlet weak var scorePicker: UIPickerView!
    @IBOutlet weak var eastWestScore: UILabel!
    @IBOutlet weak var northSouthScore: UILabel!
    
    var playerLabels: [Position: UILabel] {
        get {
            return [
                .east: eastPlayerLabel,
                .west: westPlayerLabel,
                .north: northPlayerLabel,
                .south: southPlayerLabel
            ]
        }
    }
    
    let gameStateController: GameStateController
    private var scorePickerController: ScorePickerViewController?
    private var firstOutPickerController: FirstOutPickerViewController?
    
    init(gameStateController: GameStateController) {
        self.gameStateController = gameStateController
        super.init(nibName: "ScoreHandView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported for this view controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scorePickerController = ScorePickerViewController(scoreUpdateCallback: self)
        scorePicker.dataSource = scorePickerController
        scorePicker.delegate = scorePickerController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gameState = getSafeGameState()
        
        scorePickerController?.select50Rows(pickerView: scorePicker)
        
        firstOutPickerController = FirstOutPickerViewController(players: gameState.players, scoreUpdateCallback: self)
        firstOutPicker.dataSource = firstOutPickerController
        firstOutPicker.delegate = firstOutPickerController
        firstOutPickerController?.selectFirstCaller(calls: gameState.calls, pickerView: firstOutPicker)
        
        updateScores()
        
        for position in Position.allCases {
            playerLabels[position]!.text = gameState.players[position]!.name
        }
    }
    
    private func updateScores() {
        var ewScore = scorePickerController!.eastWestScore
        ewScore += callValue(position: .east)
        ewScore += callValue(position: .west)
        eastWestScore.text = String(ewScore)
        var nsScore = scorePickerController!.northSouthScore
        nsScore += callValue(position: .north)
        nsScore += callValue(position: .south)
        northSouthScore.text = String(nsScore)
    }
    
    private func callValue(position: Position) -> Int {
        let gameState = getSafeGameState()
        if let call = gameState.calls[position],
            let selected = firstOutPickerController?.selected {
            return selected == position ? call.value() : -call.value()
        }
        return 0
    }
    
    private func getSafeGameState() -> GameState {
        guard let gameState = gameStateController.currentGame else {
            fatalError("Game state must be present to use score hand view")
        }
        return gameState
    }
    
    @IBAction func score(_ sender: Any) {
        gameStateController.recordHand(hand: Hand(
            eastWestScore: Int(eastWestScore!.text!)!,
            northSouthScore: Int(northSouthScore!.text!)!,
            firstOut: firstOutPickerController!.selected,
            calls: getSafeGameState().calls))
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelScore(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private class ScorePickerViewController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        let scores: [Int:[Int]] = [
            -25: [125],
            -20: [120],
            -15: [115],
            -10: [110],
            -5: [105],
            0: [100, 200],
            5: [95],
            10: [90],
            15: [85],
            20: [80],
            25: [75],
            30: [70],
            35: [65],
            40: [60],
            45: [55],
            50: [50],
            55: [45],
            60: [40],
            65: [35],
            70: [30],
            75: [25],
            80: [20],
            85: [15],
            90: [10],
            95: [5],
            100: [0],
            105: [-5],
            110: [-10],
            115: [-15],
            120: [-20],
            125: [-25],
            200: [0]
        ]
        
        let scoreUpdateCallback: ScoreHandViewController
        var eastWestScore = -25
        var northSouthScore = -25
        
        init(scoreUpdateCallback: ScoreHandViewController) {
            self.scoreUpdateCallback = scoreUpdateCallback
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return scores.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let score = Array(scores.keys).sorted()[row]
            return String(score)
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let score = Array(scores.keys).sorted()[row]
            guard let otherScore = scores[score]?[0] else {
                fatalError("It should be impossible to select a score that wasn't initialized but got " + String(score))
            }
            var otherRow = 0
            for key in Array(scores.keys).sorted() {
                if key == otherScore {
                    break;
                }
                otherRow += 1
            }
            let otherComponent = component == 0 ? 1 : 0
            
            pickerView.selectRow(otherRow, inComponent: otherComponent, animated: true)
            eastWestScore = component == 0 ? score : otherScore
            northSouthScore = component == 1 ? score : otherScore
            scoreUpdateCallback.updateScores()
        }
        
        func select50Rows(pickerView: UIPickerView) {
            pickerView.selectRow(15, inComponent: 0, animated: false)
            pickerView.selectRow(15, inComponent: 1, animated: false)
            eastWestScore = 50
            northSouthScore = 50
        }
    }
    
    private class FirstOutPickerViewController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        let players: [Player]
        let scoreUpdateCallback: ScoreHandViewController
        var selected: Position
        
        init(players: [Position: Player], scoreUpdateCallback: ScoreHandViewController) {
            var playersInPositionOrder: [Player] = []
            for position in Position.allCases {
                playersInPositionOrder.append(players[position]!)
            }
            self.players = playersInPositionOrder
            self.scoreUpdateCallback = scoreUpdateCallback
            selected = .east
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return players.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return players[row].name
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selected = Position.allCases[row]
            scoreUpdateCallback.updateScores()
        }
        
        func selectFirstCaller(calls: [Position: Call], pickerView: UIPickerView) {
            for position in Position.allCases {
                if let call = calls[position] {
                    if (call != .none) {
                        var row: Int
                        switch position {
                        case .east: row = 0
                        case .west: row = 1
                        case .north: row = 2
                        case .south: row = 3
                        }
                        pickerView.selectRow(row, inComponent: 0, animated: false)
                        selected = position
                        break
                    }
                }
            }
        }
    }
}
