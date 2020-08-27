//
//  CellCollectionViewCell.swift
//  GameOfLifeTwo
//
//  Created by Bobby Keffury on 8/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {
    
    func configureWithState(_ isAlive: Bool) {
        self.backgroundColor = isAlive ?  .link : .white
    }
}
