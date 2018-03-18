//
//  GridViewController.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    var game: Game
    
    var clicked: [Int]

    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        print("View Did Load")
        print(game.autoMode)
        print("view did load end")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        print("Restarting game")
        self.clicked = [Int]()
        clicked.append(0)
        var shouldEnableAutoMode = false
        if(game.autoMode){
            shouldEnableAutoMode = true
        }
        self.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: shouldEnableAutoMode)
        for tag in 1...(game.gameSize * game.gameSize){
            let tmpButton = self.view.viewWithTag(tag) as? UIButton
            tmpButton?.setImage(nil, for: .normal)
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
        if(!clicked.contains(sender.tag)){
            if(!game.finished){
                clicked.append(sender.tag)
                setImageAndCurrentPlayer(sender: sender)
                game.update(tag: sender.tag)
                checkIfWin()
                if(game.autoMode){
                    print("AI is working")
                    
                    if(clicked.count != ((game.gameSize * game.gameSize) + 1 )){
                        var randomButtonTag = 100
                        var found = false
                        while (!found){
                            randomButtonTag = Int(arc4random_uniform(UInt32(game.gameSize * game.gameSize)))
                            if(!clicked.contains(randomButtonTag)){
                                found = true
                            }
                        }
                        print("Already Clicked Buttons \(clicked)")
                        print("random button selected is\(randomButtonTag)")
                        let randomButton = self.view.viewWithTag(randomButtonTag) as! UIButton
                     
                        setImageAndCurrentPlayer(sender: randomButton)
                        game.update(tag: randomButtonTag)
                        checkIfWin()
                        clicked.append(randomButtonTag)
                    }
                    
                    
                }
                
            }
           restartButton.isHidden = false
        }
    }
    
    func checkIfWin(){
        if(game.checkIfWin()){
            winnerLabel.text = "\(game.winner.name) has won!"
        }
    }
    
    func setImageAndCurrentPlayer(sender: UIButton){
        print("current player is \(game.currentPlayer)")
        if(game.currentPlayer == 0){
            sender.setImage(UIImage(named: "zero"), for: .normal)
            game.currentPlayer = 1
            
        }else{
            sender.setImage(UIImage(named: "cross"), for: .normal)
            game.currentPlayer = 0
        }
    }
    
    func initializeClicked(){
        
    }
}
