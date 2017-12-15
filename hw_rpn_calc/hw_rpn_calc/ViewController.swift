//
//  ViewController.swift
//  hw_rpn_calc
//
//  Created by macbook_user on 9/2/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//  Implementation Checklist :
//  Point 1 to 5 implemented successfully.
//  In point 6, if the 2nd operand is not present, it will be 0 for an addition or a subraction operation and 1 for a multiplication and division operation.
//  Point 7 has been implemented. The backspace button will delete the latest typed digit on the display box. Also, an additional button of Delete has been implemented. This button will remove the lastest value from the stack.
//  Point 8 has been implemented. Though not really sure if that is what you want.
//  Point 9 has been implemented.


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Born again to this world. Like a phoenix from ashes.")
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Adios, Amigos! The Realm of the Dead beckons.")
    }
}

