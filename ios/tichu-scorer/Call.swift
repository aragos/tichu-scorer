//
//  Call.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/10/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import Foundation

enum Call : String {
    case tichu = "T"
    case grand = "GT"
    case none = ""
    
    func value() -> Int {
        switch self {
        case .tichu:
            return 100
        case .grand:
            return 200
        default:
            return 0
        }
    }
}
