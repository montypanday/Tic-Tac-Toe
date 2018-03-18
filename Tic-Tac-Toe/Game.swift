//
//  Game.swift
//  Tic-Tac-Toe
//
//  Created by Monty Panday on 16/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import Foundation

class Game {
    var player1: Player
    var player2: Player
    var winner: Player
    var gameSize: Int
    var currentPlayer: Int
    var grid = [[Int]]()
    var autoMode: Bool
    var link = [Int:(x: Int, y: Int )]()
    var finished = false
    
    // select two number to put in array that will help determine win condition
    // please note that one number must be bigger than the other to avoid wrong wins.
    let digit1 = 10
    let digit2 = 100
    
    init(player1: String, player2: String, size: Int, autoMode: Bool) {
        print("Game Mode")
        print(autoMode)
        self.player1 = Player(name: player1)
        self.player2 = Player(name: player2)
        self.gameSize = size
        self.currentPlayer = 1
        self.autoMode = autoMode
        self.grid = Array(repeating: Array(repeating: 0, count: size), count: size)
        self.winner = Player(name: "")
        let totalNoOfElements = size * size
        let tempArray = [Int](1...totalNoOfElements)
        var a = 1, b = 1
        for button in tempArray{
            link[button] = (x: a, y: b)
            if(b == size){
                b = 1
                a += 1
                continue
            }
            b += 1
        }
    }
    
    func update(tag: Int){
        if let position = link[tag]{
            if(currentPlayer == 0){
                grid[position.x - 1][position.y - 1] = digit1
            }else{
                grid[position.x - 1][position.y - 1] = digit2
            }
        }
    }
    
    func checkIfWin()-> Bool{
        checkRows()
        checkColumns()
        checkDiagonals()
        if(finished){
            return true
        }
        return false
    }
    
    func checkRows(){
        for x in 1...gameSize{
            var tempScore = 0
            for y in 1...gameSize{
                tempScore += grid[x - 1][y - 1]
            }
            checkWin(score: tempScore)
        }
    }
    
    func checkWin(score: Int){
        if(score == (digit1 * gameSize)){
            finished = true
            winner = player1
            print("Player 1 won the game")
        }
        if(score == (digit2 * gameSize)){
            finished = true
            winner = player2
            print("Player 2 won the game")
        }
    }
    
    func checkColumns(){
        for y in 1...gameSize{
            var tempScore = 0
            for x in 1...gameSize{
                tempScore += grid[x - 1][y - 1]
            }
            checkWin(score: tempScore)
        }
        
    }
    
    func checkDiagonals(){
        checkDiagonalLeftToRight()
        checkDiagonalRightToLeft()
    }
    
    func checkDiagonalLeftToRight(){
        // Check diagonal left to right
        var x = 1, y = 1
        var tempScore = 0
        repeat{
            tempScore += grid[x - 1][y - 1]
            x += 1
            y += 1
        } while x <= gameSize
        checkWin(score: tempScore)
    }
    
    func checkDiagonalRightToLeft(){
        // Check diagonal left to right
        var x = 1, y = gameSize
        var tempScore = 0
        repeat{
            tempScore += grid[x - 1][y - 1]
            x += 1
            y -= 1
        } while x <= gameSize
        checkWin(score: tempScore)
    }
}
