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
    var nubmerLabel: UILabel!

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
        
        nubmerLabel = UILabel(frame: contentView.frame)
        nubmerLabel.textAlignment = .center
        nubmerLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        contentView.addSubview(nubmerLabel)
        
//        self.contentView.backgroundColor = .white
    }
    
}
