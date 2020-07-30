//
//  MineViewController.swift
//  SmallGames
//
//  Created by 卓文城 on 2020/7/29.
//  Copyright © 2020 table. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var mineCollect: UICollectionView!
    var mineArray : [Land]!
    var cellNumber : Int!
    var mineNumber : Int!
    var cellColumn : Int!
    var number : Int!
    var timer : Timer?
    var timeNumber : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellNumber = 25
        mineNumber = 3
        cellColumn = 5
        number = 0
        timeNumber = 0
        mineCollect.dataSource = self
        mineCollect.delegate = self
        startGame()
 
    }
    
    func startGame() {
        mineArray = []
        timeNumber = 0
        number = 0
        for i in 0...cellNumber - 1 {
            mineArray.append(Land(open: false, mine: false, mineNumber: 0, landArray: []))
            
            if i == 0 { //左上
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i + 1 + cellColumn)
            } else if i == cellNumber - 1 { //右下
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i - 1 - cellColumn)
            } else if i == cellColumn - 1 { //右上
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i - 1 + cellColumn)
            } else if i == cellNumber - cellColumn { //左下
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i + 1 - cellColumn)
            } else if i < cellColumn - 1 { //上
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i - 1 + cellColumn)
                mineArray[i].landArray.append(i + 1 + cellColumn)
            } else if i > cellNumber - cellColumn { //下
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i - 1 - cellColumn)
                mineArray[i].landArray.append(i + 1 - cellColumn)
            } else if i % cellColumn == 0 { //左
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i + 1 - cellColumn)
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i + 1 + cellColumn)
            } else if (i + 1) % cellColumn == 0 { //右
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i - 1 - cellColumn)
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i - 1 + cellColumn)
            } else {
                mineArray[i].landArray.append(i - cellColumn)
                mineArray[i].landArray.append(i - 1 - cellColumn)
                mineArray[i].landArray.append(i + 1 - cellColumn)
                mineArray[i].landArray.append(i - 1)
                mineArray[i].landArray.append(i + 1)
                mineArray[i].landArray.append(i + cellColumn)
                mineArray[i].landArray.append(i - 1 + cellColumn)
                mineArray[i].landArray.append(i + 1 + cellColumn)
            }
            
        }
        
        for _ in 1...mineNumber {
            mineMake()
        }
        
        for i in 0...cellNumber - 1 {
            for j in mineArray[i].landArray {
                
                if mineArray[j].mine == true {
                    mineArray[i].mineNumber += 1
                }

            }
        }
        
        timeFunc()
        
    }
    
    func mineMake()  {
        let i = Int.random(in: 0...cellNumber - 1)
        print(i)
        if mineArray[i].mine == true {
            mineMake()
        } else {
            mineArray[i].mine = true
        }
    }
    
    func alert(massage:String) {
        let alertController = UIAlertController(title: "遊戲結束", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func timeFunc() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.timeNumber += 1
            self.timeLabel.text = "時間：\(self.timeNumber ?? 0)秒"
        })
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        
        timer?.invalidate()
        if sender.tag == 0 {
            startGame()
            mineCollect.reloadData()
        } else if sender.tag == 1 {
            cellNumber = 25
            mineNumber = 3
            cellColumn = 5
            startGame()
            mineCollect.reloadData()
        } else if sender.tag == 2 {
            cellNumber = 49
            mineNumber = 7
            cellColumn = 7
            startGame()
            mineCollect.reloadData()
        } else if sender.tag == 3 {
            cellNumber = 81
            mineNumber = 13
            cellColumn = 9
            startGame()
            mineCollect.reloadData()
        }
        
        numberLabel.text = "分數：\(number ?? 0)/\(cellNumber - mineNumber)"
        
        if sender.tag != 0 {
            for button in buttons {
                if button.tag == sender.tag {
                    button.backgroundColor = UIColor.systemBlue
                } else {
                    button.backgroundColor = UIColor.systemGreen
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

class MineCell: UICollectionViewCell {
    
    @IBOutlet weak var landImage: UIImageView!
}

struct Land {
    var open : Bool
    var mine : Bool
    var mineNumber : Int
    var landArray : [Int]
    
}

extension MineViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MineCell", for: indexPath) as? MineCell else {
            fatalError()
        }
        if mineArray[indexPath.item].open == false {
            cell.landImage.image = UIImage(named: "白框")
        } else {
            if mineArray[indexPath.item].mine == true {
                cell.landImage.image = UIImage(named: "炸彈")
            } else {
                cell.landImage.image = UIImage(named: "\(mineArray[indexPath.item].mineNumber)")
            }
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
        let width = Int(collectionView.frame.width)
        let cellWidth = width / cellColumn
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if timer?.isValid == true {
            if mineArray[indexPath.item].open == false {
                mineArray[indexPath.item].open = true
                
                if mineArray[indexPath.item].mine == false {
                    number += 1
                    numberLabel.text = "分數：\(number ?? 0)/\(cellNumber - mineNumber)"
                } else {
                    timer?.invalidate()
                    alert(massage: "踩到地雷")
                    for i in 0...cellNumber - 1 {
                        mineArray[i].open = true
                    }
                }
                
                if number == cellNumber - mineNumber {
                    timer?.invalidate()
                    alert(massage: "恭喜過關")
                    for i in 0...cellNumber - 1 {
                        mineArray[i].open = true
                    }
                }
            }
        }
        
        mineCollect.reloadData()
    }
    
}
