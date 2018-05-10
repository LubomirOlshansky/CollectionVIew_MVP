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
        collectionView.allowsSelection = false
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self.collectionView.addGestureRecognizer(singleTap)
        self.collectionView.addGestureRecognizer(doubleTap)
        
        initializeArray()

    }
    
    @objc func didSingleTap(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        if let tapIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) {
            if (self.collectionView.cellForItem(at: tapIndexPath) as? CollectionViewCell) != nil {
                if tapIndexPath.row > 0 {
                    Elements[tapIndexPath.row].number += Elements[tapIndexPath.row - 1].number
                } else {
                    Elements[tapIndexPath.row].number += Elements[Elements.count - 1].number
                }
                print("singleTap")
                collectionView.reloadData()

            }
        }
    }
    
    @objc func didDoubleTap(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        if let tapIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) {
            if (self.collectionView.cellForItem(at: tapIndexPath) as? CollectionViewCell) != nil {
                Elements[tapIndexPath.row].number = 0
                print("doubleTap")
                collectionView.reloadData()
            }
        }
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
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (otherGestureRecognizer as? UITapGestureRecognizer)?.numberOfTapsRequired == 2
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

