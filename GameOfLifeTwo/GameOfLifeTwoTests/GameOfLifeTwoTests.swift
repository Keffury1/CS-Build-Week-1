//
//  GameOfLifeTwoTests.swift
//  GameOfLifeTwoTests
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import XCTest
@testable import GameOfLifeTwo

class GameOfLifeTests: XCTestCase {

    var game = Game(width: 3, height: 3)
    
    // A live square with two or three live neighbors survives (survival)
    func test_survival() {
        let twoAliveNeighboursGameState = GameState(cells: [Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                                            Cell.newLivingCell(), Cell.newLivingCell(), Cell.newLivingCell(),
                                                            Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell()])
        game.setInitialState(twoAliveNeighboursGameState)
        XCTAssertTrue(game.state(x: 1, y: 1))
        
        let threeAliveNeighboursGameState = GameState(cells: [Cell.newDeadCell(), Cell.newLivingCell(), Cell.newDeadCell(),
                                                              Cell.newDeadCell(), Cell.newLivingCell(), Cell.newLivingCell(),
                                                              Cell.newDeadCell(), Cell.newLivingCell(), Cell.newDeadCell()])
        game.setInitialState(threeAliveNeighboursGameState)
        XCTAssertTrue(game.state(x: 1, y: 1))
    }
    
    func test_gliderState() {
        let gliderState = GameState(cells:[Cell.newDeadCell(), Cell.newLivingCell(), Cell.newDeadCell(),
                                           Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                           Cell.newDeadCell(),  Cell.newLivingCell(), Cell.newDeadCell()])
        
        game.setInitialState(gliderState)
        
        XCTAssertEqual(game.iterate(), GameState(cells:[Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                                        Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                                        Cell.newDeadCell(),Cell.newDeadCell(),Cell.newDeadCell()]))
    }
    
    //2. A dead square with exactly three live neighbors becomes a live cell (birth).
    func test_birth() {
        let deadCellState = GameState(cells:[Cell.newLivingCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                             Cell.newLivingCell(), Cell.newLivingCell(), Cell.newDeadCell(),
                                             Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell()])
        game.setInitialState(deadCellState)
        XCTAssertTrue(game.state(x: 1, y: 0))
    }
    
    //3. In all other cases a cell dies or remains dead. In the case that a live square has zero or one neighbor, it is said to die of loneliness; if it has more than three neighbors, it is said to die of overcrowding.
    func test_death() {
        let lonelyState = GameState(cells: [Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell(),
                                            Cell.newDeadCell(), Cell.newLivingCell(), Cell.newDeadCell(),
                                            Cell.newDeadCell(), Cell.newDeadCell(), Cell.newDeadCell()])
        game.setInitialState(lonelyState)
        XCTAssertEqual(false, game.state(x: 1, y: 1))
        
        let overcrowdingState = GameState(cells: [Cell.newLivingCell(), Cell.newLivingCell(), Cell.newLivingCell(),
                                                  Cell.newLivingCell(), Cell.newLivingCell(), Cell.newLivingCell(),
                                                  Cell.newLivingCell(), Cell.newLivingCell(), Cell.newLivingCell()])
        game.setInitialState(overcrowdingState)
        XCTAssertEqual(false, game.state(x: 1, y: 1))
    }

}
