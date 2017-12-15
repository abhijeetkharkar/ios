//
//  GlassView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/17/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class GlassView: UIView {
    
    override func draw(_ rect: CGRect) {
        UIColor.init(red: 112/255, green: 115/255, blue: 119/255, alpha: 0.7).setFill()
        UIColor.init(red: 84/255, green: 85/255, blue: 86/255, alpha: 1).setStroke()
        
        //let glass1 = CGRect(x: 0, y: 0, width: 110, height: 60)
        //let glass2 = CGRect(x: 150, y: 0, width: 110, height: 60)
        //rect.applying(CGAffineTransform.scaledBy(CGAffineTransform.init(scaleX: 100, y: 50)))
        
        //let glassB1: UIBezierPath = UIBezierPath(rect:glass1)
        
        //let glassB2: UIBezierPath = UIBezierPath(rect:glass1)
        
        /*glassB1.lineWidth = 8
        glassB1.addClip()
        glassB1.fill()
        glassB1.stroke()
        
        //rect.offsetBy(dx: 150, dy: 0)
        
        glassB2.lineWidth = 8
        glassB2.addClip()
        glassB2.fill()
        glassB2.stroke()*/
        
        
        let glasses1: UIBezierPath = UIBezierPath()
        glasses1.move(to: CGPoint.init(x: 0, y: 0))
        glasses1.addLine(to: CGPoint.init(x: 105, y: 0))
        glasses1.addLine(to: CGPoint.init(x: 105, y: 60))
        glasses1.addLine(to: CGPoint.init(x: 0, y: 60))
        glasses1.addLine(to: CGPoint.init(x: 0, y: 0))
        
        let glasses2: UIBezierPath = UIBezierPath()
        glasses2.move(to: CGPoint.init(x: 105, y: 40))
        glasses2.addQuadCurve(to: CGPoint.init(x: 135, y: 40), controlPoint: CGPoint.init(x: 120, y: 20))
        
        let glasses3: UIBezierPath = UIBezierPath()
        glasses3.move(to: CGPoint.init(x: 135, y: 0))
        glasses3.addLine(to: CGPoint.init(x: 240, y: 0))
        glasses3.addLine(to: CGPoint.init(x: 240, y: 60))
        glasses3.addLine(to: CGPoint.init(x: 135, y: 60))
        glasses3.addLine(to: CGPoint.init(x: 135, y: 0))
        
        glasses1.lineWidth = 8
        //glasses1.addClip()
        glasses1.fill()
        glasses1.stroke()
        
        glasses3.lineWidth = 8
        glasses3.fill()
        //glasses3.addClip()
        glasses3.stroke()
        
        glasses2.lineWidth = 8
        glasses2.stroke()
        glasses2.addClip()
    }
}
