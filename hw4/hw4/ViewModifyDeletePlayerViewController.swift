//
//  ViewModifyDeletePlayerViewController.swift
//  hw4
//
//  Created by macbook_user on 9/27/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class ViewModifyDeletePlayerViewController: UIViewController {
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    var keyArray:[String] = []
    
    @IBOutlet weak var dobText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var educationText: UITextField!
    @IBOutlet weak var majorText: UITextField!
    @IBOutlet weak var matchesPlayedText: UITextField!
    @IBOutlet weak var averageScore: UITextField!
    @IBOutlet weak var highScore: UITextField!
    @IBOutlet weak var rpnValue: UITextField!
    @IBOutlet weak var activatedOnText: UITextField!
    
    @IBOutlet weak var playerDetails: UIView!
    
    @IBOutlet weak var validationMessageLabel: UILabel!
    
    @IBOutlet weak var activateButton: UIButton!
    
    @IBAction func nameBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        nameText.backgroundColor = UIColor.white
    }
    
    @IBAction func dobBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        dobText.backgroundColor = UIColor.white
    }
    
    @IBAction func educationBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        educationText.backgroundColor = UIColor.white
    }
    
    @IBAction func majorBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        majorText.backgroundColor = UIColor.white
    }
    
    @IBAction func modify(_ sender: UIButton) {
        //print(nameText.text)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        if(nameText.text == nil || nameText.text == "") {
            nameText.backgroundColor = UIColor.red
            validationMessageLabel.text = "Name is mandatory"
            validationMessageLabel.isHidden = false
        } else if(emailText.text == nil || emailText.text == "") {
            emailText.backgroundColor = UIColor.red
            validationMessageLabel.text = "Email ID is mandatory"
            validationMessageLabel.isHidden = false
        } else if (!emailTest.evaluate(with: emailText.text)) {
            emailText.backgroundColor = UIColor.red
            validationMessageLabel.text = "Invalid Email ID"
            validationMessageLabel.isHidden = false
        }else if(educationText.text == nil || educationText.text == "") {
            educationText.backgroundColor = UIColor.red
            validationMessageLabel.text = "Education is mandatory"
            validationMessageLabel.isHidden = false
        } else {
            
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: emailText.text!)!)
            let player = data as! Player
            player.name = nameText.text!
            player.education = educationText.text!
            player.major = majorText.text!
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: emailText.text!)
            playerDatabase.synchronize()
            
            /*This is important. This will take you back to the parent*/
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        nameText.text = ""
        educationText.text = ""
        majorText.text = ""
        nameText.backgroundColor = UIColor.white
        educationText.backgroundColor = UIColor.white
        majorText.backgroundColor = UIColor.white
        validationMessageLabel.isHidden = true
    }
    
    @IBAction func activatePressed() {
        activateButton.isEnabled = false
        activateButton.alpha = 0.3
        
        if(playerDatabase.object(forKey: "activeUserKey") == nil) {
            playerDatabase.set(emailText.text!, forKey: "activeUserKey")
            
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: emailText.text!)!)
            let player = data as! Player
            player.isActive = true
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            player.activatedOn = formatter.string(from : Date())
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: emailText.text!)
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
            
            let currentActivePlayerKey = emailText.text!
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
        }
    }
    
    @IBAction func deletePressed() {
        playerDatabase.removeObject(forKey: emailText.text!)
        playerDatabase.removeObject(forKey: "activeUserKey")
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        print("ViewModifyDeletePlayer View Did Load")
        
        self.view = GradientSelector().setGradient(view: self.view, type: 2)
        playerDetails = GradientSelector().setGradient(view: playerDetails, type: 0)
        
        validationMessageLabel.isHidden = true
        
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
        
        let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: TournamentStandingsViewController.selectedRowKey)!)
        let player = data as! Player
        nameText.text = player.name
        emailText.text = player.email
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dobText.text = formatter.string(from : player.dob)
        educationText.text = player.education
        majorText.text = player.major
        matchesPlayedText.text = String(player.matchesPlayed)
        averageScore.text = String(player.averageScore)
        highScore.text = String(player.highScore)
        rpnValue.text = String(player.rpn)
        activatedOnText.text = player.activatedOn
        if(player.isActive == true) {
            activateButton.isEnabled = false
            activateButton.alpha = 0.3
        } else {
            activateButton.isEnabled = true
            activateButton.alpha = 1.0
        }
        
        print("KeyArray Count is \(keyArray.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewModifyDeletePlayer View Did Appear")
        
        validationMessageLabel.isHidden = true
        
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
        
        print("KeyArray Count is \(keyArray.count)")
    }
}
