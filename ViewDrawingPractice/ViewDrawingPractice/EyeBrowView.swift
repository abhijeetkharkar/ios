//
//  EyeBrowView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/14/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class EyeBrowView: UIView {

    override func draw(_ rect: CGRect) {
        UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
        let brow : UIBezierPath = UIBezierPath()
        brow.move(to: CGPoint.init(x: 0, y: 30))
        brow.addQuadCurve(to: CGPoint.init(x: 114, y: 30), controlPoint: CGPoint.init(x: 57, y: -10))
        
        brow.addClip()
        brow.lineWidth = 14
        brow.stroke()
    }
}
