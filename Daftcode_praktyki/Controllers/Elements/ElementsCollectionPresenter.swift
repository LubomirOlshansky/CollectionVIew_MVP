//
//  ElementsCollectionPresenter.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 10/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit


class ElementsCollectionPresenter: NSObject {
    
    //MARK: Properties
    var elements = [Element]()
    let backgroundColor: UIColor = .white
    private let cellIdentifier = "Cell"
    typealias makeOperationComplition = (() -> Void)
    
     //MARK: Methods
    func initializeArray() {
        for _ in 0...9 {
            self.elements.append(Element())
        }
    }
    
    func subtractionOperation(indexPath: Int, completion: @escaping makeOperationComplition) {
        if indexPath > 0 {
            elements[indexPath].number += elements[indexPath - 1].number
        } else {
            elements[indexPath].number += elements[elements.count - 1].number
        }
        completion()
    }
    
    func isZeroOperation(indexPath: Int, completion: @escaping makeOperationComplition) {
        elements[indexPath].number = 0
        completion()
        
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
    }
}

    //MARK: UICollectionView data source
    extension ElementsCollectionPresenter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.changeColorAndText(with: elements[indexPath.row])
        
        return cell
    }
}
