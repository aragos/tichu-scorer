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
    
    func getCall() -> String {
        let selected = callControl.selectedSegmentIndex
        if (selected == 0) {
            return "T"
        } else if (selected == 2) {
            return "GT"
        } else {
            return ""
        }
    }
    
    func resetCall() {
        callControl.selectedSegmentIndex = 1
    }
}

