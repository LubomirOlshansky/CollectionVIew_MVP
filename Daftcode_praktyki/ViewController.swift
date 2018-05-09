//
//  ViewController.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 09/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var Elements = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeArray()

    }
    
    func initializeArray() {
        for _ in 0...9 {
            self.Elements.append(Element(number: Int(arc4random_uniform(10)), color: .Red))
        }
        
    }
    
    
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        switch Elements[indexPath.row].color {
        
        case .Red:
            cell.circleView.backgroundColor = UIColor.red
            cell.nubmerLabel.text = String((Elements[indexPath.row].number) * 3)
        case .Blue:
            cell.circleView.backgroundColor = UIColor.blue
            cell.nubmerLabel.text = String(Elements[indexPath.row].number)
        }
        return cell
    }
   
}


struct Element {
    var number: Int
    var color: Color
    
//    init() {
//        self.number = random(0..<11)
//        self.color = .Blue
//    }
    
    
    
}
enum Color {
    case Red
    case Blue
    
    
}


//extension Elements {
//    func random(_ range:Range<Int>) -> Int
//    {
//        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
//    }
//}

