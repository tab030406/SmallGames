//
//  GopherViewController.swift
//  SmallGames
//
//  Created by 卓文城 on 2020/7/21.
//  Copyright © 2020 table. All rights reserved.
//

import UIKit

class GopherViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var collect: UICollectionView!
    var holeArray : [Bool]!
    var number : Int!
    var timer : Timer?
    var timeNumber : Int!
    var cellNumber : Int!
    var difficulty : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        holeArray = []
        number = 0
        timeNumber = 20
        cellNumber = 9
        difficulty = 1
        for _ in 0...cellNumber - 1 {
            holeArray.append(false)
        }
        
        start()
            
        collect.delegate = self
        collect.dataSource = self
        

       
    }
    
    func start() {
        number = 0
        timeNumber = 20
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in

            if self.timeNumber % 2 == 0 {
                for i in 0...self.cellNumber - 1 {
                    self.holeArray[i] = false
                }
                
                
                for _ in 1...self.difficulty {
                    self.holeArray[Int.random(in: 0...self.cellNumber - 1)] = true
                }
            }
                
            self.timeLabel.text = "  時間：\(self.timeNumber ?? 0)"
            self.timeNumber -= 1
            self.collect.reloadData()
            self.numberLable.text = "  分數：\(self.number ?? 0)"
            self.timeLabel.text = "  時間：\(self.timeNumber ?? 0)"
            if self.timeNumber == 0 {
                
                for i in 0...self.cellNumber - 1 {
                    self.holeArray[i] = false
                }

                self.timer?.invalidate()
            }
            
        })
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        
        timer?.invalidate()
        
        if sender.tag == 0 {
            
            start()
            
        } else if sender.tag == 1 {
            
            cellNumber = 9
            difficulty = 1
            buttonChange()
            
        } else if sender.tag == 2 {
            
            cellNumber = 16
            difficulty = 2
            buttonChange()
            
        } else if sender.tag == 3 {
            
            cellNumber = 25
            difficulty = 3
            buttonChange()
            
        }
        
        holeArray = []
        
        for _ in 0...cellNumber - 1 {
            
            holeArray.append(false)
            
        }
        
        collect.reloadData()
        
    }
    
    func buttonChange() {
        for button in buttons {
            
            if button.tag == difficulty {
                button.backgroundColor = UIColor.systemBlue
            } else {
                button.backgroundColor = UIColor.systemGreen
            }
            
        }
        
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

class CollectCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
}

extension GopherViewController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as? CollectCell else {
            fatalError()
        }
        
        if holeArray[indexPath.item] == false {
            cell.cellImage.image = UIImage(named: "地洞")
        } else {
            cell.cellImage.image = UIImage(named: "地鼠")
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 3
        if difficulty == 3 {
            height = Int(collectionView.frame.height / 5)
        } else if difficulty == 2 {
            height = Int(collectionView.frame.height / 4)
        } else {
            height = Int(collectionView.frame.height / 3)
        }
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if holeArray[indexPath.item] == true {
            holeArray[indexPath.item] = false
            number += 1
            collect.reloadData()
        }
    }
    
    
}
