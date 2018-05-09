//
//  CollectionViewCell.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 09/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nubmerLabel: UILabel!
    @IBOutlet weak var circleView: UIView! {
        didSet {
            let side = circleView.frame.width
            circleView.layer.cornerRadius = side * 0.5
            circleView.clipsToBounds = true
        }
    }
    
    
}
