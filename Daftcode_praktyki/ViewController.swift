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
            self.Elements.append(Element())
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        switch Elements[indexPath.row].color {
        
        case .red:
            cell.circleView.backgroundColor = UIColor.red
            cell.nubmerLabel.text = String((Elements[indexPath.row].number) * 3)
        case .blue:
            cell.circleView.backgroundColor = UIColor.blue
            cell.nubmerLabel.text = String(Elements[indexPath.row].number)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            Elements[indexPath.row - 1].number += Elements[indexPath.row].number
        } else {
            Elements[Elements.count - 1].number += Elements[indexPath.row].number
        }
        
        collectionView.reloadData()
    }
   
}


struct Element {
    var number: Int
    var color: Color
    
    init() {
        self.number = Int(arc4random_uniform(10))
        self.color = Color.randomColor()
    }
}

enum Color {
    case red
    case blue
    
    static func randomColor() -> Color {
        let colorsToGetRandomly = [Color.red, Color.blue]
        let index = Int(arc4random_uniform(UInt32(colorsToGetRandomly.count)))
        let color = colorsToGetRandomly[index]
        return color
    }
}

