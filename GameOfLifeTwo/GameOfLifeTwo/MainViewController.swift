//
//  ViewController.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    var cells: [Cell] = []
    var game: Game!
    var speed: Float = 1.0
    var width = 25
    var height = 25
    
    // MARK: - Outlets
    
    @IBOutlet weak var generationsLabel: UILabel!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var presetOne: UIButton!
    @IBOutlet weak var presetTwo: UIButton!
    @IBOutlet weak var presetThree: UIButton!
    @IBOutlet weak var presetFour: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var speedSegmentedControl: UISegmentedControl!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        setupSubviews()
        game = Game(width: width, height: height)
    }
    
    // MARK: - Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(CellCollectionViewCell.self, forCellWithReuseIdentifier: "cellCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCell", for: indexPath) as! CellCollectionViewCell
        cell.configureWithState(cells[indexPath.item].isAlive)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    // MARK: - Methods
    
    func display(_ state: GameState) {
        self.cells = state.cells
        gridCollectionView.reloadData()
        self.generationsLabel.text = "\(game.generation)\nGenerations"
    }
    
    func setupSubviews() {
        presetOne.layer.cornerRadius = 10.0
        presetTwo.layer.cornerRadius = 10.0
        presetThree.layer.cornerRadius = 10.0
        presetFour.layer.cornerRadius = 10.0
    }
    
    func startGame() {
        game.addStateObserver(speed: speed) { [weak self] state in
            self?.display(state)
        }
        self.startButton.isEnabled = false
        self.stopButton.isEnabled = true
    }
    
    // MARK: - Actions
    
    @IBAction func rateOfPlayChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            speed = 0.5
        } else if sender.selectedSegmentIndex == 1 {
            speed = 0.3
        } else {
            speed = 0.1
        }
    }
    
    @IBAction func presetOneTapped(_ sender: Any) {
        game.preset1()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func presetTwoTapped(_ sender: Any) {
        game.preset2()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func presetThreeTapped(_ sender: Any) {
        game.preset3()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func presetFourTapped(_ sender: Any) {
        game.preset4()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        startGame()
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        game.stop()
        self.startButton.isEnabled = true
        self.stopButton.isEnabled = false
    }
    
    @IBAction func trashButtonTapped(_ sender: Any) {
        game.clear()
        cells.removeAll()
        gridCollectionView.reloadData()
        generationsLabel.text = "0\nGenerations"
        self.startButton.isEnabled = true
        self.stopButton.isEnabled = false
    }
}

