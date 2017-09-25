//
//  CollectionTableViewCell.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import Foundation
import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet private var collectionView: UICollectionView!
    
    func setCollectionViewDataSource<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, withRow row: Int) {
        
        Logging.JLog(message: "row : \(row)")
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        
        
        collectionView.reloadData()
    }

}
