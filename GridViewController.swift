//
//  GridViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class GridViewController: UIViewController{
    
    var game: Game
    
    var clicked: [Int]
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        self.clicked = [Int]()
        clicked.append(0)
        self.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: game.autoMode)
        for button in buttons{
            button.setImage(nil, for: .normal)
        }
        restartButton.isHidden = true
        winnerLabel.text = ""
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: false)
        self.clicked = [Int]()
        clicked.append(0)
        super.init(coder: aDecoder)
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        if(!clicked.contains(sender.tag) && (!game.finished)){
            playTurn(sender: sender)
            restartButton.isHidden = false
            if(game.autoMode && clicked.count != ((game.gameSize * game.gameSize) + 1 ) && !game.finished){
                var randomButtonTag = 100
                var found = false
                while (!found){
                    randomButtonTag = Int(arc4random_uniform(UInt32(game.gameSize * game.gameSize)))
                    if(!clicked.contains(randomButtonTag)){
                        found = true
                    }
                }
                let randomButton = self.view.viewWithTag(randomButtonTag) as! UIButton
                playTurn(sender: randomButton)
            }
        }
    }
    
    func playTurn(sender: UIButton){
        clicked.append(sender.tag)
        setImageAndCurrentPlayer(sender: sender)
        game.update(tag: sender.tag)
        checkIfWin()
    }
    
    func checkIfWin(){
        if(game.checkIfWin()){
            winnerLabel.text = "\(game.winner.name) has won!"
        }
    }
    
    func setImageAndCurrentPlayer(sender: UIButton){
        switch game.currentPlayer {
        case 0:
            sender.setImage(#imageLiteral(resourceName: "zero"), for: .normal)
            game.currentPlayer = 1
            break
        case 1:
            sender.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
            game.currentPlayer = 0
            break
        default: break
        }
    }
}
