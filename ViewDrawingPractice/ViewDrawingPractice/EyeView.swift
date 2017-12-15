//
//  EyeView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/11/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class EyeView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        UIColor.init(red: 1, green: 1, blue: 240/255, alpha: 1).setFill()
        UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        let circle: UIBezierPath = UIBezierPath(ovalIn:rect)
        //let pattern: [CGFloat] = [5.0, 5.0]
        circle.lineWidth = 6
        circle.addClip()
        circle.fill()
        //circle.setLineDash(pattern, count: 2, phase: 0.0)
        circle.stroke()
    }
    
}

