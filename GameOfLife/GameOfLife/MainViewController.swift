//
//  MainViewController.swift
//  GameOfLife
//
//  Created by Bobby Keffury on 8/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var generationsLabel: UILabel!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var presetsCollectionView: UICollectionView!
    @IBOutlet weak var rateOfPlaySlider: UISlider!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    
    @IBAction func rateOfPlayChanged(_ sender: Any) {
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rulesButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
