//
//  TicTacToeViewController.swift
//  SmallGames
//
//  Created by 卓文城 on 2020/7/31.
//  Copyright © 2020 table. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    @IBOutlet var checkerButton: [UIButton]!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var usersButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    var player : Player!
    var oplayer : Set<Int>!
    var xplayer : Set<Int>!
    var winArray : Set<Set<Int>>!
    var secend : [Set<Int> : Int]!
    var space : Set<Int>!
    var time : Int!
    var mode : Int!
    var game :Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = 2
        winArray = [[0,1,2],[3,4,5],[6,7,8],
                    [0,3,6],[1,4,7],[2,5,8],
                    [0,4,8],[2,4,6]]
        secend = [[0,1]:2,[0,2]:1,[1,2]:0,
                  [3,4]:5,[3,5]:4,[4,5]:3,
                  [6,7]:8,[6,8]:7,[7,8]:6,
                  [0,3]:6,[0,6]:3,[3,6]:0]
        newGame()

        
    }
    @IBAction func checkerAction(_ sender: UIButton) {
        if mode == 2 {
            switch player {
            case .o:
                sender.setImage(UIImage(named: "O"), for: .disabled)
                oplayer.insert(sender.tag)
                player = .x
                userLabel.text = "X"
                userLabel.textColor = UIColor.systemRed
                
            case .x:
                sender.setImage(UIImage(named: "X"), for: .disabled)
                xplayer.insert(sender.tag)
                player = .o
                userLabel.text = "O"
                userLabel.textColor = UIColor.systemBlue
                
            case .none:
                return
            }
            time += 1
            sender.isEnabled = false
            win()
            
        } else if mode == 1 {
            sender.setImage(UIImage(named: "O"), for: .disabled)
            oplayer.insert(sender.tag)
            space.remove(sender.tag)
            time += 1
            sender.isEnabled = false
            
            win()

            if game == true {
                var first = [Int]()
                var second = [Int]()
                var third = [Int]()
                for index in winArray {
                    let intersect = xplayer.intersection(index)
                    let subtract = index.subtracting(intersect)
                    var setArray = Array(subtract)
                    print(setArray)
                    if setArray.count == 1 && space.contains(setArray[0]) {
                        first.append(setArray[0])
                    } else if setArray.count != 1{
                        let set = space.intersection(subtract)
                        setArray = Array(set)
                        for i in setArray {
                            third.append(i)
                        }
                    }
                    let oplayerIntersect = oplayer.intersection(index)
                    let oplayerSubtract = index.subtracting(oplayerIntersect)
                    let oplayerSetArray = Array(oplayerSubtract)
                    if oplayerSetArray.count == 1 && space.contains(oplayerSetArray[0]) {
                        second.append(oplayerSetArray[0])
                    }
                }
                var number = 0
                if first != [] {
                    number = randomNumber(arrayName: "first", intArray: first)
                } else if second != [] {
                    number = randomNumber(arrayName: "second", intArray: second)
                } else if third != [] {
                    number = randomNumber(arrayName: "third", intArray: third)
                } else {
                    let spaceArray = Array(space)
                    number = randomNumber(arrayName: "new", intArray: spaceArray)
                }
                xplayerAction(number: number)
                win()
            }
        }
    }
    
    func randomNumber(arrayName: String,intArray: [Int]) -> Int {
        print("\(arrayName) = \(intArray)")
         let number = Int.random(in: 0...intArray.count - 1)
        print("\(arrayName)Number = \(intArray[number])")
        return intArray[number]
    }
    
    func xplayerAction(number: Int) {
        checkerButton[number].setImage(UIImage(named: "X"), for: .disabled)
        checkerButton[number].isEnabled = false
        xplayer.insert(number)
        space.remove(number)
        time += 1
    }
    
    func win()  {
        for set in winArray {
            
            if oplayer.isSuperset(of: set) {
                alert(massage: "藍Ｏ Win")
                
            } else if xplayer.isSuperset(of: set) {
                alert(massage: "紅Ｘ Win")
            
            }
        }
        
        if time == 9 {
            alert(massage: "雙方平手")
        }
    }
    @IBAction func modeAction(_ sender: UIButton) {
        newGame()
        if sender.tag == 0 {
            
        } else if sender.tag == 1 {
            
            mode = 1
            userButton.backgroundColor = UIColor.systemBlue
            usersButton.backgroundColor = UIColor.systemGreen
        } else {
            mode = 2
            userButton.backgroundColor = UIColor.systemGreen
            usersButton.backgroundColor = UIColor.systemBlue
        }
    }
    
    enum Player {
        case x
        case o
    }
    
    func alert(massage:String) {
        game = false
        for button in checkerButton {
            button.isEnabled = false
        }
        let alertController = UIAlertController(title: "遊戲結束", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: { _ in
            self.newGame()
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        return
    }
    
    func newGame() {
        player = Player.o
        oplayer = []
        xplayer = []
        time = 0
        space = [0,1,2,3,4,5,6,7,8]
        game = true
        for button in checkerButton {
            button.setImage(UIImage(named: "白框"), for: .normal)
            button.setImage(UIImage(named: "白框"), for: .disabled)
            button.isEnabled = true
        }
        
        userLabel.text = "O"
        userLabel.textColor = UIColor.systemBlue
    }

}
