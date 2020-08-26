//
//  Cell.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

struct Cell {
    var alive: Bool = false
    
    static func newDeadCell() -> Cell {
        return Cell(alive: false)
    }
    
    static func newLivingCell() -> Cell {
        return Cell(alive: true)
    }
}
