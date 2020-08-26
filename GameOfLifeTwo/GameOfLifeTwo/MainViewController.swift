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
    var speed: Float = 0.1
    
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
        self.game = Game(width: 25, height: 25)
    }
    
    // MARK: - Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCell", for: indexPath) as? CellCollectionViewCell else { return UICollectionViewCell() }
        cell.configureWithState(alive: cells[indexPath.row].alive)
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
    }
    
    @IBAction func presetTwoTapped(_ sender: Any) {
        game.preset2()
    }
    
    @IBAction func presetThreeTapped(_ sender: Any) {
        game.preset3()
    }
    
    @IBAction func presetFourTapped(_ sender: Any) {
        game.preset4()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        game.addStateObserver(speed: speed) { [weak self] state in
            self?.display(state)
        }
        self.startButton.isEnabled = false
        self.stopButton.isEnabled = true
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        game.removeStateObserver()
        game.stop()
        self.startButton.isEnabled = true
        self.stopButton.isEnabled = false
    }
    
    @IBAction func trashButtonTapped(_ sender: Any) {
        game.clear()
        cells.removeAll()
        gridCollectionView.reloadData()
        generationsLabel.text = "0\nGenerations"
    }
}

