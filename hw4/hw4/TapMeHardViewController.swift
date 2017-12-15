//
//  TapMeViewController.swift
//  hw4
//
//  Created by macbook_user on 9/22/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class TapMeHardViewController: UIViewController {
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    
    var tapCount: Int = 0
    var gameStarted:Bool = false
    var timer:Timer!
    var remainingTime:Int = 10
    
    @IBOutlet weak var countDown: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        print("Born again to this world. Like a phoenix from ashes.")
        status.text = "Test your Tap Speed."
        self.view=GradientSelector().setGradient(view: self.view,type: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func updateCountDown() {
        if(remainingTime>0) {
            remainingTime = remainingTime - 1
            countDown.text = "Count Down: \(remainingTime)"
        } else {
            timer.invalidate()
            gameStarted = false
            
            /*
             Changes for storing the tap game records for the active player
             */
            if(playerDatabase.object(forKey: "activeUserKey") != nil) {
                let activePlayerKey = playerDatabase.object(forKey: "activeUserKey") as! String
                let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: activePlayerKey)!)
                let player = data as! Player
                
                //What has to be done in case of an exception while converting a String to Double? How to set the "rpn" value to 0.0 in such a case
                
                let matches = player.matchesPlayed!
                let avgScore = player.averageScore!
                let highScore = player.highScore!
                
                player.matchesPlayed = matches + 1
                player.averageScore = ((avgScore * Double(matches))+Double(tapCount))/Double((matches+1))
                player.highScore = tapCount > highScore ? tapCount : highScore
                
                print("HMatches=\(matches), HAvgScore=\(avgScore), HHighScore=\(highScore), CMatches=\(player.matchesPlayed), CAvgScore=\(player.averageScore), CHighScore=\(player.highScore)")
                
                /*
                 NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
                 */
                let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
                playerDatabase.set(encodedData, forKey: activePlayerKey)
                playerDatabase.synchronize()
            }
            
            startGameButton.isEnabled = true
            startGameButton.alpha = 1.0
            remainingTime = 10
            countDown.text = "Count Down: 10"
            tapCount = 0
            
            status.text = "Time's Up. Try Again!!!"
        }
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        //print("button pressed")
        gameStarted=true
        startGameButton.isEnabled = false
        startGameButton.alpha = 0.3
        status.text = "Game ON!!!"
        timer = Timer.scheduledTimer(timeInterval:1.0, target:self, selector:#selector(TapMeHardViewController.updateCountDown), userInfo: nil, repeats: true)
    }
    
    @IBAction func countTaps(_ sender: UITapGestureRecognizer) {
        //print("screen tapped")
        if(gameStarted) {
            tapCount = tapCount + 1
            score.text = "Score: \(tapCount)"
        }
    }
    
}
