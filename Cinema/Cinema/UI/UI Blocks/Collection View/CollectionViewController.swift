//
//  ViewController.swift
//  Cinema
//
//  Created by Alex on 9/20/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.keyboardDismissMode = .onDrag
    }
    
    func configure(with configuration: CollectionViewPresenterConfiguration) {
        let cellNibName = configuration.cellType.reuseIdentifier        
        configuration.dataSource?.configureWith(collectionView: collectionView)
        collectionView.delegate = configuration.collectionViewDelegate
        collectionView.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: cellNibName)
        collectionView.collectionViewLayout = configuration.layout
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}


