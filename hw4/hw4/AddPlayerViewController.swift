//
//  AddPlayer.swift
//  hw4
//
//  Created by macbook_user on 9/25/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    var keyArray:[String] = []
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var educationText: UITextField!
    @IBOutlet weak var majorText: UITextField!
    @IBOutlet weak var playerDetails: UIView!
    @IBOutlet weak var validationMessageLabel: UILabel!
    
    @IBAction func nameBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        nameText.backgroundColor = UIColor.white
    }
    
    @IBAction func emailBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        emailText.backgroundColor = UIColor.white
    }
    
    @IBAction func educationBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        educationText.backgroundColor = UIColor.white
    }
    
    @IBAction func majorBeingEdited(_ sender: UITextField) {
        validationMessageLabel.isHidden = true
        majorText.backgroundColor = UIColor.white
    }
    
    @IBAction func submit(_ sender: UIButton) {
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
            let srNoValue = keyArray.count + 1
            print("Sr. No. is \(srNoValue)")
            let player:Player = Player(srNo: srNoValue, name: nameText.text!, email: emailText.text!, education: educationText.text!, major: (majorText.text == nil || majorText.text == "") ? "" : majorText.text!, dob: datePicker.date, matchesPlayed: 0, averageScore: 0.0, highScore: 0, rpn: 0.0, isActive: false, activatedOn: "")
            
            let playerInDatabase = playerDatabase.data(forKey: emailText.text!)
            if(playerInDatabase == nil) {
                print("AddPlayer, Inside If")
                /*
                 NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
                */
                let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
                print("AddPlayer, Inside If, After Encode")
                playerDatabase.set(encodedData, forKey: emailText.text!)
                playerDatabase.synchronize()
                
                /*This is important. This will take you back to the parent*/
                _ = navigationController?.popToRootViewController(animated: true)
            } else {
                emailText.backgroundColor = UIColor.red
                validationMessageLabel.text = "Email ID already registered"
                validationMessageLabel.isHidden = false
            }
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        nameText.text = ""
        emailText.text = ""
        educationText.text = ""
        majorText.text = ""
        nameText.backgroundColor = UIColor.white
        emailText.backgroundColor = UIColor.white
        educationText.backgroundColor = UIColor.white
        majorText.backgroundColor = UIColor.white
        validationMessageLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        print("AddPlayer View Did Load")
        
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
        
        print("KeyArray Count is \(keyArray.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("AddPlayer View Did Appear")
        
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
