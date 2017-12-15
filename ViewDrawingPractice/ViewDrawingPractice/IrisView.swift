//
//  IrisView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/11/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class IrisView: UIView {
    
    var value:UIColor = UIColor.cyan
    
    func setColor(val:String) {
        //print("Inside setValue, value is \(val))")
        switch val {
        case "cyan":
            value = UIColor.cyan
        case "brown" :
            value = UIColor.brown
        case "blue" :
            value = UIColor.blue
        case "yellow" :
            value = UIColor.yellow
        case "green" :
            value = UIColor.green
        case "red" :
            value = UIColor.red
        default:
            value = UIColor.cyan
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        value.setStroke()
        value.setFill()
        let circle: UIBezierPath = UIBezierPath(ovalIn:rect)
        circle.lineWidth = 1
        circle.addClip()
        circle.fill()
        circle.stroke()
    }
    
}

