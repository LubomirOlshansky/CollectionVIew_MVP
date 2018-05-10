//
//  ViewController.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 09/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let presenter: ElementsCollectionPresenter!
    var collectionView: UICollectionView!

    init(with presenter: ElementsCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        collectionView.backgroundColor = UIColor.white
        presenter.initializeArray()

    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = presenter
        presenter.registerCells(for: collectionView)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self.collectionView.addGestureRecognizer(singleTap)
        self.collectionView.addGestureRecognizer(doubleTap)
        self.view.addSubview(collectionView)
    }
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: insetLeft,
                                           bottom: 5.0,
                                           right: insetRight)
        let itemSide = UIScreen.main.bounds.width / 3 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        return layout
    }()
    
    @objc func didSingleTap(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        if let tapIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) {
            if (self.collectionView.cellForItem(at: tapIndexPath) as? CollectionViewCell) != nil {
            
                DispatchQueue.global().async {
                    self.presenter.subtractionOperation(indexPath: tapIndexPath.row)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func didDoubleTap(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        if let tapIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) {
            if (self.collectionView.cellForItem(at: tapIndexPath) as? CollectionViewCell) != nil {
                DispatchQueue.global().async {
                    self.presenter.isZeroOperation(indexPath: tapIndexPath.row)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
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


