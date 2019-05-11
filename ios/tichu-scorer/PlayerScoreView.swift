//
//  PlayerScoreView.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/5/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit

class PlayerScoreView: UIView {

    @IBOutlet var contentView: PlayerScoreView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var callControl: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerScoreView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setPlayerName(name: String) {
        playerNameLabel.text = name
    }
    
    func getCall() -> Call {
        let selected = callControl.selectedSegmentIndex
        if (selected == 0) {
            return .tichu
        } else if (selected == 2) {
            return .grand
        } else {
            return .none
        }
    }
    
    func setCall(call: Call) {
        var selected: Int
        switch call {
        case .tichu:
            selected = 0
        case .grand:
            selected =  2
        default:
            selected =  1
        }
        callControl.selectedSegmentIndex = selected
    }
}

