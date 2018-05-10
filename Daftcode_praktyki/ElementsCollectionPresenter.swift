//
//  ElementsCollectionPresenter.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 10/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit


class ElementsCollectionPresenter: NSObject {
    
    var Elements = [Element]()
    private let cellIdentifier = "Cell"
    
    func initializeArray() {
        for _ in 0...9 {
            self.Elements.append(Element())
        }
    }
    
    func subtractionOperation(indexPath: Int) {
        if indexPath > 0 {
            Elements[indexPath].number += Elements[indexPath - 1].number
        } else {
            Elements[indexPath].number += Elements[Elements.count - 1].number
        }
    }
    
    func isZeroOperation(indexPath: Int) {
        Elements[indexPath].number = 0
    }
    
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension ElementsCollectionPresenter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
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
