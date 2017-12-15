//
//  RPNModel.swift
//  hw_rpn_calc
//
//  Created by macbook_user on 9/2/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import Foundation

struct Stack {
    var data: [Double] = []
    
    mutating func push(_ number:Double) {
        data.append(number)
    }
    
    mutating func pop() -> Double {
        let top:Double = data[data.count - 1]
        data.removeLast()
        return top
    }
    
    func isEmpty() -> Bool {
        if (data.count > 0) {
            return false
        } else {
            return true
        }
    }
    
    mutating func flush() {
        data.removeAll()
    }
}

class RPNModel {
    var stack = Stack()
    
    func stackValues(_ operand: String) {
        print("Stack Values Called")
        stack.push(Double(operand)!)        
    }
    
    func performOperation(_ operate: String) -> String {
        
        print("Perform Operation Called")
        
        var result = ""
        
        if (operate == "π") {
            print("π to be pushed in the stack")
            stack.push(Double.pi)
            result = String(Double.pi)
        } else {
            if(stack.isEmpty()) {
                result=""
            } else {
                let operand1 = stack.pop()
                print("Operand1 popped out of the stack is " + String(operand1) + " and operator is " + operate)
                if(operate == "+") {
                    if(stack.isEmpty()) {
                        result = String(operand1)
                        stack.push(operand1)
                    } else {
                        let operand2 = stack.pop()
                        result = String(operand1 + operand2)
                        stack.push(operand1 + operand2)
                    }
                } else if (operate == "-") {
                    if(stack.isEmpty()) {
                        result = String(operand1)
                        stack.push(operand1)
                    } else {
                        let operand2 = stack.pop()
                        result = String(operand2 - operand1)
                        stack.push(operand2 - operand1)
                    }
                } else if (operate == "*") {
                    if(stack.isEmpty()) {
                        print("Inside multiply, stack is empty")
                        result = String(operand1)
                        stack.push(operand1)
                    } else {
                        let operand2 = stack.pop()
                        print("Inside multiply, operand2 is " + String(operand2))
                        result = String(operand1 * operand2)
                        stack.push(operand1 * operand2)
                    }
                } else if (operate == "÷") {
                    if(stack.isEmpty()) {
                        result = String(operand1)
                        stack.push(operand1)
                    } else {
                        if(operand1 == 0.0) {
                            result = "Divide By Zero. Use C."
                        } else {
                            let operand2 = stack.pop()
                            result = String(operand2 / operand1)
                            stack.push(operand2 / operand1)
                        }
                    }
                } else if (operate == "sin") {
                    print("Inside sin, operand1 is " + String(operand1))
                    result = String(sin(operand1*Double.pi/180))
                    stack.push(sin(operand1*Double.pi/180))
                } else if (operate == "cos") {
                    result = String(cos(operand1*Double.pi/180))
                    stack.push(cos(operand1*Double.pi/180))
                } else if (operate == "tan") {
                    result = String(tan(operand1*Double.pi/180))
                    stack.push(tan(operand1*Double.pi/180))
                } else if (operate == "√") {
                    if(operand1 != -1) {
                        result = String(sqrt(operand1))
                        stack.push(sqrt(operand1))
                    } else {
                        result = ""
                        stack.push(-1)
                    }
                } else if (operate == "±") {
                    result = String(operand1 * -1)
                    stack.push(operand1 * -1)
                } else if (operate == "C") {
                    stack.flush()
                    result = ""
                } else if (operate == "Del") {
                    result = ""
                } else {
                    result = "highalert"
                }
            }
        }
        
        
        
        print("Final Result is " + result)
    
        return result
    }
}
