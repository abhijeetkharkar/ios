//
//  CircleView.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/7/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class FaceView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        UIColor.init(red: 212/255, green: 166/255, blue: 160/255, alpha: 1).setStroke()
        UIColor.init(red: 1, green: 217/255, blue: 170/255, alpha: 1).setFill()
        let circle: UIBezierPath = UIBezierPath(ovalIn:rect)
        circle.lineWidth = 4
        circle.addClip()
        circle.fill()
        circle.stroke()
    }

}
