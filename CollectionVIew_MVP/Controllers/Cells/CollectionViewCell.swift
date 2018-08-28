//
//  CollectionViewCell.swift
//  CollectionVIew_MVP
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
        numberLabel = UILabel(frame: contentView.frame)

        circleView.layer.cornerRadius = circleView.frame.width * 0.5
        
        contentView.addSubview(circleView)
        contentView.addSubview(numberLabel)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        
        
    }
    
    func changeColorAndText(with element: Element) {
        
        switch element.color {
            
        case .red:
            circleView.backgroundColor = .red
            numberLabel.text = String(element.number * 3)
            numberLabel.sizeToFit()
        case .blue:
            circleView.backgroundColor = .blue
            numberLabel.text = String(element.number)
            numberLabel.sizeToFit()
        }
    }
}
