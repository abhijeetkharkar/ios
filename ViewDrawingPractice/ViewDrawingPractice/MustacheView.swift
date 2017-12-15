//
//  MustacheView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/15/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class MustacheView: UIView {
    
    var value:Float = 1
    
    func setControlValue(val:Float) {
        value = val;
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        
        let mustauche:UIBezierPath = UIBezierPath()
        let pattern: [CGFloat] = [1.0, 1.0]
        mustauche.setLineDash(pattern, count: 2, phase: 0.0)
        
        mustauche.move(to: CGPoint.init(x: 10, y: Int(50*value)))
        mustauche.addQuadCurve(to: CGPoint.init(x: 55, y: 10), controlPoint: CGPoint.init(x: 20, y: 15))
        mustauche.addQuadCurve(to: CGPoint.init(x: rect.width-65, y: 10), controlPoint: CGPoint.init(x: rect.width/2, y: 10))
        mustauche.addQuadCurve(to: CGPoint.init(x: rect.width-10, y: (CGFloat(50*value))), controlPoint: CGPoint.init(x: rect.width-20, y: 15))
        
        mustauche.lineWidth = 17
        mustauche.stroke()
        mustauche.addClip()
    }
}
