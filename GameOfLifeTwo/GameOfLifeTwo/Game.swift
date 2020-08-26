//
//  Game.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

class Game {
    
    typealias GameStateObserver = ((GameState) -> Void)?
    
    let width: Int
    let height: Int
    var currentState: GameState
    var generation: Int
    var timer: Timer?
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.generation = 0
        let cells = Array(repeating: Cell.newDeadCell(), count: width * height)
        currentState = GameState(cells: cells)
    }
    
    func addStateObserver(speed: Float, _ observer: GameStateObserver) {
        observer?(generateRandomState())
        timer = Timer.scheduledTimer(withTimeInterval: Double(speed), repeats: true) { _ in
            observer?(self.iterate())
        }
    }
    
    func removeStateObserver() {
        NotificationCenter.default.removeObserver(GameStateObserver.self)
    }
    
    func stop() {
        self.makeStopState()
    }
    
    @discardableResult
    func makeStopState() -> GameState {
        timer?.invalidate()
        return self.currentState
    }
    
    func clear() {
        self.makeClearState()
    }
    
    @discardableResult
    func makeClearState() -> GameState {
        for point in 0...624 {
            currentState[point] = Cell.newDeadCell()
        }
        timer?.invalidate()
        return self.currentState
    }
    
    
    func preset1() {
        self.makePreset1State()
    }
    
    @discardableResult
    func makePreset1State() -> GameState {
        generation = 0
        
        for point in 0...300 {
            currentState[point] = Cell.newDeadCell()
        }
        for point in 0...300 {
            if point % 2 == 0 {
                currentState[point] = Cell.newLivingCell()
            }
        }
        return self.currentState
    }
    
    func preset2() {
        self.makePreset2State()
    }
    
    @discardableResult
    func makePreset2State() -> GameState {
        generation = 0
        
        for point in 0...300 {
            currentState[point] = Cell.newDeadCell()
        }
        for point in 150...300 {
            currentState[point] = Cell.newLivingCell()
        }
        return self.currentState
    }
    
    func preset3() {
        self.makePreset3State()
    }
    
    @discardableResult
    func makePreset3State() -> GameState {
        generation = 0
        
        for point in 0...300 {
            currentState[point] = Cell.newDeadCell()
        }
        for point in 0...100 {
            currentState[point] = Cell.newLivingCell()
        }
        return self.currentState
    }
    
    func preset4() {
        self.makePreset4State()
    }
    
    @discardableResult
    func makePreset4State() -> GameState {
        generation = 0
        
        for point in 0...300 {
            currentState[point] = Cell.newDeadCell()
        }
        for point in 0...24 {
            currentState[point] = Cell.newLivingCell()
        }
        return self.currentState
    }
    
    func iterate() -> GameState {
        var nextState = currentState
        self.generation += 1
        for i in 0...width - 1 {
            for j in 0...height - 1 {
                let position = j * width + 1
                nextState[position] = Cell(alive: state(x: i, y: j))
            }
        }
        
        self.currentState = nextState
        return nextState
    }
    
    func state(x: Int, y: Int) -> Bool {
        let neighborsAlive = aliveNeighborCount(x: x, y: y)
        let position = x + y * width
        let previouslyAlive = currentState[position].alive
        if previouslyAlive {
            return neighborsAlive == 2 || neighborsAlive == 3
        } else {
            return neighborsAlive == 3
        }
    }
    
    func aliveNeighborCount(x: Int, y: Int) -> Int {
        var neighborsAlive = 0
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                if (i == x && y == j) || (i >= width) || (i < 0) || (j < 0) { continue }
                
                let index = j * width + i
                
                guard index >= 0 && index < width * height else { continue }
                if currentState[index].alive {
                    neighborsAlive += 1
                }
            }
        }
        return neighborsAlive
    }
    
    func setInitialState(_ state: GameState) {
        currentState = state
    }
    
    private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
        return Array(0...count).map { _ in
            Int.random(in: range)
        }
    }
    
    @discardableResult
    func generateRandomState() -> GameState {
        generation = 0
        let maxItems = width * height - 1
        for point in 0...maxItems {
            currentState[point] = Cell.newDeadCell()
        }
        
        let initialStatePoints = self.generateRandom(between: 0...maxItems, count: maxItems/8)
        
        for point in initialStatePoints {
            currentState[point] = Cell.newLivingCell()
        }
        
        return self.currentState
    }
}

