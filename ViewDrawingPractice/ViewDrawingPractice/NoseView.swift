//
//  NoseView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/11/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class NoseView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        UIColor.init(red: 212/255, green: 166/255, blue: 160/255, alpha: 1).setStroke()
        UIColor.init(red: 1, green: 210/255, blue: 165/255, alpha: 1).setFill()
        
        let nose: UIBezierPath = UIBezierPath()
        nose.move(to: CGPoint.init(x: 25, y: 0))
        nose.addQuadCurve(to: CGPoint.init(x: 30, y: 35), controlPoint: CGPoint.init(x: 35, y: 25))
        nose.addQuadCurve(to: CGPoint.init(x: 15, y: 90), controlPoint: CGPoint.init(x: 25, y: 75))
        nose.addQuadCurve(to: CGPoint.init(x: 12, y: 125), controlPoint: CGPoint.init(x: 0, y: 120))
        
        nose.addQuadCurve(to: CGPoint.init(x: 40, y: 135), controlPoint: CGPoint.init(x: 30, y: 130))
        nose.addQuadCurve(to: CGPoint.init(x: 50, y: 135), controlPoint: CGPoint.init(x: 45, y: 140))
        
        nose.addQuadCurve(to: CGPoint.init(x: 78, y: 125), controlPoint: CGPoint.init(x: 55, y: 135))
        nose.addQuadCurve(to: CGPoint.init(x: 75, y: 90), controlPoint: CGPoint.init(x: 90, y: 120))
        nose.addQuadCurve(to: CGPoint.init(x: 60, y: 35), controlPoint: CGPoint.init(x: 65, y: 75))
        nose.addQuadCurve(to: CGPoint.init(x: 65, y: 0), controlPoint: CGPoint.init(x: 55, y: 25))
        
        nose.lineWidth = 4
        nose.addClip()
        nose.fill()
        nose.stroke()
    }
    
}


