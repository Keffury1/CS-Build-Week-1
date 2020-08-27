//
//  Game.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

typealias GameStateObserver = ((GameState) -> Void)?

class Game {
    let width: Int
    let height: Int
    var currentState: GameState
    var generation: Int
    var timer: Timer?
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.generation = 0
        let cells = Array(repeating: Cell.makeDeadCell(), count: width*height)
        self.currentState = GameState(cells: cells)
    }
    
    // MARK: - Game Logic
    
    func addStateObserver(speed: Float, _ observer: GameStateObserver) {
        observer?(generateInitialState())
        timer = Timer.scheduledTimer(withTimeInterval: Double(speed), repeats: true) { _ in
            observer?(self.iterate())
        }
    }
    
    func iterate() -> GameState  {
        var nextState = currentState
        generation += 1
        for i in 0...width - 1 {
            for j in 0...height - 1 {
                let positionInTheArray = j*width + i
                nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
            }
        }
        self.currentState = nextState
        return nextState
    }
    
    func state(x: Int, y: Int) -> Bool {
        let numberOfAliveNeighbours = aliveNeighbourCountAt(x: x, y: y)
        let position = x + y*width
        
        let wasPrevioslyAlive = currentState[position].isAlive
        if wasPrevioslyAlive {
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else {
            return numberOfAliveNeighbours == 3
        }
    }
    
    func aliveNeighbourCountAt(x: Int, y: Int) -> Int {
        var numberOfAliveNeighbours = 0
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                if (i == x && y == j) || (i >= width) || (i < 0) || (j < 0 ) {continue}
                
                let index = j*width + i
                
                guard index >= 0 && index < width*height else {continue}
                if currentState[index].isAlive {
                    numberOfAliveNeighbours += 1
                }
            }
        }
        return numberOfAliveNeighbours
    }
    
    func setInitialState(_ state: GameState) {
        currentState = state
    }
    
    @discardableResult
    func generateInitialState() -> GameState {
        let maxItems = width*height - 1
        let initialStatePoints = self.generateRandom(between: 0...maxItems, count: maxItems/8)

        for point in initialStatePoints{
            currentState[point] = Cell.makeLiveCell()
        }
        return self.currentState
    }
    
    private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
        return Array(0...count).map { _ in
            Int.random(in: range)
        }
    }
    
    
    // MARK: - Gameplay
    
    @discardableResult
    func stop() -> GameState {
        timer?.invalidate()
        return self.currentState
    }
    
    @discardableResult
    func clear() -> GameState {
        generation = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        timer?.invalidate()
        return self.currentState
    }
    
    // Methods that run preset configurations on the game board
    @discardableResult
    func preset1() -> GameState {
        return self.currentState
    }
    
    @discardableResult
    func preset2() -> GameState {
        return self.currentState
    }
    
    @discardableResult
    func preset3() -> GameState {
        return self.currentState
    }
    
    @discardableResult
    func preset4() -> GameState {
        return self.currentState
    }
    
}

