//
//  YSMmemCollectionViewController.swift
//  YSMeMe
//
//  Created by Youssef Eid on 05/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit

class YSMmemCollectionViewController: UICollectionViewController {

    @IBOutlet weak var cfFlowlayout: UICollectionViewFlowLayout!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let cellWidth = (view.frame.size.width - (5 * space)) / 3.0
        cfFlowlayout.minimumInteritemSpacing = space
        cfFlowlayout.itemSize = CGSize(width:cellWidth, height: cellWidth + 30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return YSMemeDatabase.sheard().dataSources.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCells", for: indexPath) as? YSMemeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let meme = YSMemeDatabase.sheard().dataSources[indexPath.row]
        cell.setupMemeView(meme: meme)
        return cell
    }

    
    
}
