//
//  GopherViewController.swift
//  SmallGames
//
//  Created by 卓文城 on 2020/7/21.
//  Copyright © 2020 table. All rights reserved.
//

import UIKit

class GopherViewController: UIViewController {
    @IBOutlet weak var collect: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collect.delegate = self
        collect.dataSource = self

       
    }
    

  
}

class CollectCell: UICollectionViewCell {
    
    @IBOutlet weak var cellButton: UIButton!
}

extension GopherViewController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as? CollectCell else {
            fatalError()
        }
        cell.cellButton.setTitle("", for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = Int(collectionView.frame.height / 5)
        return CGSize(width: height, height: height)
    }
    
    
}
