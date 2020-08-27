//
//  Cell.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

struct Cell {
    var isAlive = false
    
    static func makeDeadCell() -> Cell {
        return Cell(isAlive: false)
    }
    
    static func makeLiveCell() -> Cell {
        return Cell(isAlive: true)
    }
}
