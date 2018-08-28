//
//  ViewController.swift
//  CollectionVIew_MVP
//
//  Created by Lubomir Olshansky on 09/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
     //MARK: Properties
    let presenter: ElementsCollectionPresenter!
    var collectionView: UICollectionView!
    
    enum TapCount: Int { case single = 1, double }

    init(with presenter: ElementsCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter.initializeArray()

    }
    
    private func getTap(with count: TapCount) -> UITapGestureRecognizer {
        
        let selector = count == .single ? #selector(didSingleTap) : #selector(didDoubleTap)
        let singleTap = UITapGestureRecognizer(target: self, action: selector)
        singleTap.numberOfTapsRequired = count.rawValue
        singleTap.delegate = self
        
        return singleTap
    }
    
    //MARK: Methods
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = presenter.backgroundColor
        collectionView.delegate   = self
        collectionView.dataSource = presenter
        presenter.registerCells(for: collectionView)
        
        collectionView.addGestureRecognizer(getTap(with: TapCount.single))
        collectionView.addGestureRecognizer(getTap(with: TapCount.double))
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: insetLeft, bottom: 5.0, right: insetRight)
        let itemSide = UIScreen.main.bounds.width / 3 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        return layout
    }()
    
    
    private func didTap(with tap: TapCount, gesture: UITapGestureRecognizer) {
        
        let pointInCollectionView: CGPoint = gesture.location(in: collectionView)
        
        if let tapIndexPath = collectionView.indexPathForItem(at: pointInCollectionView) {
            
            if (collectionView.cellForItem(at: tapIndexPath) as? CollectionViewCell) != nil {
                switch tap {
                case .single:
                    self.presenter.subtractionOperation(indexPath: tapIndexPath.row) { [weak self] in
                        
                            self?.collectionView.reloadData()
                    }
                case .double:
                    self.presenter.resetOperation(indexPath: tapIndexPath.row) { [weak self] in
                            self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func didSingleTap(gesture: UITapGestureRecognizer) {
        didTap(with: TapCount.single, gesture: gesture)
    }
    
    @objc func didDoubleTap(gesture: UITapGestureRecognizer) {
        didTap(with: TapCount.double, gesture: gesture)
    }
}
    

extension ElementsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (otherGestureRecognizer as? UITapGestureRecognizer)?.numberOfTapsRequired == 2
    }
}


