//
//  ViewController.swift
//  hw4
//
//  Created by macbook_user on 9/22/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class TournamentStandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    var keyArray:[String] = []
    static var selectedRowKey:String = ""
    
    @IBOutlet weak var mainTable: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.backgroundColor = UIColor.blue
        return "Players' Standings"
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView called")
        return keyArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TournamentStandingsViewController.selectedRowKey = keyArray[indexPath.row]
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
            cell.detailTextLabel?.text = "Games Played:"+String(player.matchesPlayed)+"|High Score:"+String(player.highScore)
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
    
    override func viewDidLoad() {
        print("Tournament Standings View Loaded")
        
        self.view=GradientSelector().setGradient(view: self.view,type: 0)
        
        mainTable = GradientSelector().setGradient(view: mainTable,type: 2) as! UITableView
        
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

