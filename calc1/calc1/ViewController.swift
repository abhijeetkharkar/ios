//
//  ViewController.swift
//  calc1
//
//  Created by macbook_user on 8/29/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var operand1 = ""
    var operand2 = ""
    var operator1 = ""
    var operatorSet = false
    
    @IBOutlet weak var calcOP: UILabel!
    
    @IBAction func onePress(_ sender: UIButton) {
        print(sender.currentTitle ?? "nil")
        storeKey(sender.currentTitle ?? "nil")
        
    }
    
    func storeKey(_ keyPressed: String){
        //print("i am here")
        if(keyPressed != "nil") {
            if(keyPressed == "0" || keyPressed == "1" || keyPressed == "2" || keyPressed == "3" || keyPressed == "4" || keyPressed == "5" || keyPressed == "6" || keyPressed == "7" || keyPressed == "8" || keyPressed == "9" || keyPressed == ".") {
                //print("yes")
                if (operatorSet) {
                    operand2 += keyPressed
                    calcOP.text = calcOP.text! + operand2
                } else {
                    operand1 += keyPressed
                    calcOP.text = calcOP.text! + operand1
                }
            } else {
                //print("no no")
                if(keyPressed == "=") {
                    if(operatorSet) {
                        calcOP.text = calculate(operand1,operand2,operator1)
                        operand1 = ""
                        operand2 = ""
                        operator1 = ""
                        operatorSet = false
                    } else {
                        calcOP.text = operand1
                        operand1 = ""
                    }
                } else if (keyPressed == "C") {
                    calcOP.text = ""
                    operand1 = ""
                    operand2 = ""
                    operator1 = ""
                    operatorSet = false
                } else {
                    if(operatorSet) {
                        if(operand1 != "" && operand2 != "") {                            operand1 = calculate(operand1, operand2, operator1)
                            calcOP.text = operand1 + keyPressed
                            operator1 = keyPressed
                            operand2 = ""
                        } else if(operand1 == "" && operand2 == "") {
                            operator1 = ""
                            calcOP.text = ""
                        } else {
                            
                        }
                    } else {
                        operator1 = keyPressed
                        operatorSet = true
                        calcOP.text = calcOP.text! + keyPressed
                    }
                }
            }
        } else {
            //print("no")
        }
    }
    
    func calculate(_ operand1 : String, _ operand2 : String, _ operator1 : String)  -> String {
        print(operand1+","+operator1+","+operand2)
        var result = 0.0
        if(operator1 == "+") {
            result = Double(operand1)! + Double(operand2)!
        }
        if(operator1 == "-") {
            result = Double(operand1)! - Double(operand2)!
        }
        if(operator1 == "*") {
            result = Double(operand1)! * Double(operand2)!
        }
        if(operator1 == "/") {
            result = Double(operand1)! / Double(operand2)!
        }
        return String(result)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

