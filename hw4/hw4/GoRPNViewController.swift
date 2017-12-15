//
//  GoRPNViewController.swift
//  hw4
//
//  Created by macbook_user on 9/22/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class GoRPNViewController: UIViewController {
    let playerDatabase:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        print("Born again to this world. Like a phoenix from ashes.")
        self.view=GradientSelector().setGradient(view: self.view,type: 1)
    }
    
    var operand = ""
    var operate = ""
    var log = ""
    var enterPressed = false
    var decimalPressedOnce = false
    
    var model = RPNModel()
    
    @IBOutlet weak var calcLog: UILabel!
    @IBOutlet weak var displayBox: UILabel!
    
    @IBAction func operandPress(_ sender: UIButton) {
        if(operand == String(Double.pi)) {
            operand = ""
        }
        if(sender.currentTitle! == "." && decimalPressedOnce) {
            operand = operand + ""
        } else {
            operand = operand + sender.currentTitle!
        }
        
        displayBox.text = operand
        print("Operand is "+operand)
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        print("Operator is " + sender.currentTitle!)
        if (sender.currentTitle! == "Enter") {
            if(operand != "") {
                enterPressed = true
                print("Final Operand before pushing in stack is " + operand)
                if(operand == ".") {
                    operand = "0"
                }
                model.stackValues(operand)
                calcLog.text = calcLog.text! + operand + " "
                displayBox.text = ""
                operand = ""
                decimalPressedOnce = false
            }
            
        } else if (sender.currentTitle! == "C") {
            let result = model.performOperation("C")
            operand = ""
            operate = ""
            displayBox.text = result
            calcLog.text = result
        } else if (sender.currentTitle! == "Del") {
            let result = model.performOperation("Del")
            operand = ""
            operate = ""
            displayBox.text = result
        } else if (sender.currentTitle! == "⌫") {
            operand = operand.substring(to: operand.index(operand.endIndex, offsetBy: -1))
            displayBox.text = operand
        } else if (sender.currentTitle! == "±") {
            if(enterPressed) {
                let result = model.performOperation("±")
                operand = ""
                operate = ""
                displayBox.text = result
                enterPressed = false
            } else {
                if(operand == "." || operand == "0") {
                    operand = "0"
                } else {
                    if(operand.contains(".")) {
                        let temp = Double(operand)! * (-1)
                        operand = String(temp)
                        displayBox.text = operand
                    } else {
                        let temp = Int(operand)! * (-1)
                        operand = String(temp)
                        displayBox.text = operand
                    }
                }
            }
        } else {
            operate = sender.currentTitle!
            let result = model.performOperation(operate)
            if (operate == "π") {
                operand = result
                calcLog.text = calcLog.text! + operate + " "
            } else {
                calcLog.text = calcLog.text! + operate + " = "
            }
            
            operate = ""
            /*var length = result.characters.count
             length = length - 20
             let temp = result.index(length, offsetBy: result.endIndex)
             displayBox.text = result.substring(to: temp)*/
            displayBox.text = result
            
        }
        /*
         Changes for storing the latest value in on the screen in the "rpn" attribute of the active player
        */
        if(playerDatabase.object(forKey: "activeUserKey") != nil) {
            let activePlayerKey = playerDatabase.object(forKey: "activeUserKey") as! String
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: activePlayerKey)!)
            let player = data as! Player
            
            //What has to be done in case of an exception while converting a String to Double? How to set the "rpn" value to 0.0 in such a case
            if(displayBox.text! == "") {
                player.rpn = 0.0
            } else {
                player.rpn = Double(displayBox.text!)
            }
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: activePlayerKey)
            playerDatabase.synchronize()
        }
    }
    
    override func didReceiveMemoryWarning() {
        print("Adios, Amigos! The Realm of the Dead beckons.")
    }
}

