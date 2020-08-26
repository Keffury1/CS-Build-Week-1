//
//  GameState.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

struct GameState {
    var cells: [Cell] = []
    
    subscript(index: Int) -> Cell {
        get {
            return cells[index]
        } set {
            cells[index] = newValue
        }
    }
}

extension GameState: Equatable {
    public static func == (left: GameState, right: GameState) -> Bool {
        for leftCell in left.cells {
            for rightCell in right.cells {
                if leftCell.alive != rightCell.alive {
                    return false
                }
            }
        }
        return true
    }
}

