//
//  HairView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/17/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class HairView: UIView {
    
    var value:UIColor = UIColor.black
    
    func setControlValue(val:Int) {
        //print("Inside setValue, value is \(val))")
        switch val {
        case 1:
            value = UIColor.black
        case 2 :
            value = UIColor.brown
        case 3 :
            value = UIColor.gray
        case 4 :
            value = UIColor.yellow
        case 5 :
            value = UIColor.orange
        default:
            value = UIColor.black
        }        
        self.setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        value.setFill()
        let hair: UIBezierPath = UIBezierPath()
        let w = rect.width
        let h = rect.height
        
        print(rect.width)
        
        print(rect.height)
        
        hair.move(to: CGPoint(x: 0, y: h))
        //hair.addQuadCurve(to: CGPoint(x: w, y: 123), controlPoint: CGPoint(x: w/2, y: -123))
        hair.addQuadCurve(to: CGPoint.init(x: w/16+10, y: h/3), controlPoint: CGPoint.init(x: 0, y: h/2))
        hair.addLine(to: CGPoint.init(x: w/8, y: 2*h/3-10))
        hair.addQuadCurve(to: CGPoint.init(x: w/4-15, y: 20), controlPoint: CGPoint.init(x: w/8, y: h/4))
        hair.addLine(to: CGPoint.init(x: w/4, y: h/3-10))
        hair.addQuadCurve(to: CGPoint.init(x: w/2, y: 0), controlPoint: CGPoint.init(x: w/4, y: 0))
        
        hair.addQuadCurve(to: CGPoint.init(x: 3*w/4, y: h/3-10), controlPoint: CGPoint.init(x: 3*w/4 , y: 0))
        hair.addLine(to: CGPoint.init(x: 3*w/4+15, y: 20))
        hair.addQuadCurve(to: CGPoint.init(x: 7*w/8, y: 2*h/3-10), controlPoint: CGPoint.init(x: 7*w/8, y: h/4))
        hair.addLine(to: CGPoint.init(x: 15*w/16-10, y: h/3))
        hair.addQuadCurve(to: CGPoint.init(x: w, y: h), controlPoint: CGPoint.init(x: w, y: h/2))
        
        
        hair.addQuadCurve(to: CGPoint(x: w - w/3, y: 123), controlPoint: CGPoint(x: w-15, y: 130))
        hair.addQuadCurve(to: CGPoint(x: w/3, y: 123), controlPoint: CGPoint(x: w/2, y: 140))
        hair.addQuadCurve(to: CGPoint(x: 0, y: h), controlPoint: CGPoint(x: 15, y: 130))
        
        hair.addClip()
        hair.fill()
        hair.stroke()
    }
}
