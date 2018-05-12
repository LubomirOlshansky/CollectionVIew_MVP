//
//  CollectionViewCell.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 09/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
//    @IBOutlet weak var nubmerLabel: UILabel!
    
    
    var circleView: UIView!
    var numberLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        circleView = UIView(frame: contentView.frame)
        let side = circleView.frame.width
        circleView.layer.cornerRadius = side * 0.5
        circleView.clipsToBounds = true
        contentView.addSubview(circleView)
        
        numberLabel = UILabel(frame: contentView.frame)
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        contentView.addSubview(numberLabel)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func changeColorAndText(with element: Element) {
        
        switch element.color {
            
        case .red:
            circleView.backgroundColor = .red
            numberLabel.text = String(element.number * 3)
//            numberLabel.sizeToFit()
        case .blue:
            circleView.backgroundColor = .blue
            numberLabel.text = String(element.number)
//            numberLabel.sizeToFit()
        }
    }
}
