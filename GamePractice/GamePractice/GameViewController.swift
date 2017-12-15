//
//  GameViewController.swift
//  GamePractice
//
//  Created by macbook_user on 10/10/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var addPlayer: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    var keyArray:[String] = []
    static var selectedRowKey:String = ""
    var homeScreen : UIViewController!
    
    @IBOutlet weak var mainTable: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.backgroundColor = UIColor.blue
        return "Leaderboard"
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView called")
        return keyArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GameViewController.selectedRowKey = keyArray[indexPath.row]
        
        /*
        Click on the cell to toggle between activation and deactivation
        */
        
        if(playerDatabase.object(forKey: "activeUserKey") == nil) {
            playerDatabase.set(GameViewController.selectedRowKey, forKey: "activeUserKey")
            
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: GameViewController.selectedRowKey)!)
            let player = data as! Player
            player.isActive = true
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            player.activatedOn = formatter.string(from : Date())
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: GameViewController.selectedRowKey)
            playerDatabase.synchronize()
        } else {
            let lastActivePlayerKey = playerDatabase.object(forKey: "activeUserKey") as! String
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: lastActivePlayerKey)!)
            let player = data as! Player
            player.isActive = false
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: lastActivePlayerKey)
            playerDatabase.synchronize()
            
            let currentActivePlayerKey = GameViewController.selectedRowKey
            playerDatabase.set(currentActivePlayerKey, forKey: "activeUserKey")
            
            let dataNow = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: currentActivePlayerKey)!)
            let playerNow = dataNow as! Player
            playerNow.isActive = true
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            playerNow.activatedOn = formatter.string(from : Date())
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedDataNow:Data = NSKeyedArchiver.archivedData(withRootObject: playerNow)
            playerDatabase.set(encodedDataNow, forKey: currentActivePlayerKey)
            playerDatabase.synchronize()
            
            viewDidAppear(true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNum:Int = indexPath.row
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "playerCell")! as UITableViewCell
        keyArray.sort()
        if(keyArray.count != 0) {
            print("Cell Num = \(cellNum)")
            /*
             NSKeyedUnarchiver.unarchiveObject is used to retrieve the encoded data from UserDefaults
             */
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: keyArray[cellNum])!)
            let player = data as! Player
            print("Player Name is \(player.name) and email is \(player.email) and key is \(keyArray[cellNum])")
            cell.textLabel?.text = player.name
            cell.textLabel?.font = cell.textLabel?.font.withSize(25.0)
            //cell.detailTextLabel?.text = player.email+"|Games Played:"+String(player.matchesPlayed)+"|High Score:"+String(player.highScore)
            let matches = String(player.matchesPlayed)
            let average = String(Double(round(100*player.averageScore)/100))
            let highscore = String(player.highScore)
            cell.detailTextLabel?.text = "Games Played:"+matches+"|Average Score:"+average+"|High Score:"+highscore
            cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(10.0)
            cell.detailTextLabel?.font = UIFont.init(name: "AmericanTypewriter-Condensed", size: 12.0)
            if(player.isActive) {
                cell.imageView?.image = UIImage(named: "active")
            } else {
                cell.imageView?.image = UIImage(named: "inactive")
            }
            
            playerDatabase.synchronize()
        }
        return cell
    }

    @IBAction func startNewGame() {
        //startNewGameButton.isHidden = true
        mainTable.isHidden = true
        addPlayer.isHidden = true
        startNewGameButton.isHidden = true
        self.view.layer.sublayers?[0].removeFromSuperlayer()
        
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    sceneNode.gameViewController = self
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        print("Tournament Standings View Loaded")
        
        (self.view as! SKView).presentScene(nil)
        
        self.view=GradientSelector().setGradient(view: self.view,type: 5)
        
        mainTable.isHidden = false
        addPlayer.isHidden = false
        startNewGameButton.isHidden = false
        
        //mainTable = GradientSelector().setGradient(view: mainTable,type: 5) as! UITableView
        mainTable.backgroundColor = UIColor.init(red: 1, green: 163/255, blue: 102/255, alpha: 1)
        
        /*
         This piece of code is used to remove all data from UserDefaults
         */
        //let domain = Bundle.main.bundleIdentifier!
        //UserDefaults.standard.removePersistentDomain(forName: domain)
        //UserDefaults.standard.synchronize()
        
        keyArray = []
        
        for (key, value) in playerDatabase.dictionaryRepresentation() {
            if((value as? Data) != nil) {
                print("Key is \(key) AND Value is \(value)")
                let playerDataTemp = NSKeyedUnarchiver.unarchiveObject(with: value as! Data)
                if((playerDataTemp as? Player) != nil) {
                    keyArray.append(key)
                }
            }
        }
        
        playerDatabase.synchronize()
        
        /*
         UITableView.reloadData will refresh the table view when the view is loaded or appears
         */
        mainTable.reloadData()
        
        print("KeyArray Count is \(keyArray.count)")
    }
    
    override func viewDidAppear(_ animated:Bool) {
        print("Tournament Standings View Appeared")
        
        mainTable.isHidden = false
        addPlayer.isHidden = false
        startNewGameButton.isHidden = false
        
        keyArray = []
        
        for (key, value) in playerDatabase.dictionaryRepresentation() {
            if((value as? Data) != nil) {
                print("Key is \(key) AND Value is \(value)")
                let playerDataTemp = NSKeyedUnarchiver.unarchiveObject(with: value as! Data)
                if((playerDataTemp as? Player) != nil) {
                    keyArray.append(key)
                }
            }
        }
        
        playerDatabase.synchronize()
        
        /*
         reloadData will refresh the table view when the view is loaded or appears
         */
        mainTable.reloadData()
        
        print("KeyArray Count is \(keyArray.count)")
    }
}
