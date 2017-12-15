//
//  MouthView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/12/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class MouthView: UIView {

    var value:Float = 1
    
    func setValue1(val:Float) {
        //print("Inside setValue, value is \(val))")
        value = val
        self.setNeedsDisplay()
    }
    
    var color:UIColor = UIColor.init(red: 1, green: 128/255, blue: 128/255, alpha: 1)
    
    func setColor(val:String) {
        //print("Inside setValue, value is \(val))")
        switch val {
        case "cyan":
            color = UIColor.cyan
        case "brown" :
            color = UIColor.brown
        case "blue" :
            color = UIColor.blue
        case "yellow" :
            color = UIColor.yellow
        case "green" :
            color = UIColor.green
        case "red" :
            color = UIColor.red
        case "pink" :
            color = UIColor.init(red: 1, green: 128/255, blue: 128/255, alpha: 1)
        default:
            color = UIColor.init(red: 1, green: 128/255, blue: 128/255, alpha: 1)
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        color.setFill()
        UIColor.init(red: 1, green: 77/255, blue: 77/255, alpha: 1).setStroke()
        let mouth :UIBezierPath = UIBezierPath()
        
        
        mouth.move(to: CGPoint(x: 0, y: 35))
        mouth.addQuadCurve(to: CGPoint(x: 100, y: 10), controlPoint: CGPoint(x: 80, y: -18))
        mouth.addQuadCurve(to: CGPoint(x: 200, y: 35), controlPoint: CGPoint(x: 120, y: -18))
        mouth.addQuadCurve(to: CGPoint(x: 100, y: Int(32*value)), controlPoint: CGPoint(x: 175, y: Int(25*value)))
        mouth.addQuadCurve(to: CGPoint(x: 0, y: 35), controlPoint: CGPoint(x: 50, y: Int(25*value)))
        mouth.addQuadCurve(to: CGPoint(x: 200, y: 35), controlPoint: CGPoint(x: 100, y: Int(105*value)))
        
        mouth.lineWidth = 5
        mouth.addClip()
        mouth.fill()
        mouth.stroke()
        
        mouth.move(to: CGPoint(x: 200, y: 35))
        mouth.addQuadCurve(to: CGPoint(x: 100, y: 32), controlPoint: CGPoint(x: 175, y: 25))
        mouth.addQuadCurve(to: CGPoint(x: 0, y: 35), controlPoint: CGPoint(x: 50, y: 25))
        mouth.addQuadCurve(to: CGPoint(x: 200, y: 35), controlPoint: CGPoint(x: 100, y: 35))
    }

}
