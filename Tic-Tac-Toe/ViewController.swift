//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by MONTY PANDAY on 13/3/18.
//  Copyright © 2018 deakin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func singlePlayerChosen(_ sender: UIButton) {
        print("Single Player Mode is chosen")
    }
    
    @IBAction func multiPlayerChosen(_ sender: UIButton) {
        print("Multi Player Mode is chosen")
    }
    
    @IBAction func retrieveHistory(_ sender: UIButton) {
        print("Let's try to retrieve previously played game")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        print(segue.destination)
        if let destination = segue.destination as? GridViewController{
            if(segue.identifier == "single"){
            destination.game = Game(player1: "player1", player2: "player2", size: 4, autoMode: true)
            }
            
        }
    }


}

