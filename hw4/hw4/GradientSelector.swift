//
//  GradientSelector.swift
//  hw4
//
//  Created by macbook_user on 9/24/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class GradientSelector {
    var gradientLayer:CAGradientLayer!
    
    func setGradient(view:UIView, type:Int) -> UIView{
        gradientLayer = CAGradientLayer();
        gradientLayer.frame = view.bounds
        switch type {
        case 0:
            gradientLayer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        case 1:
            gradientLayer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor, UIColor.black.cgColor]
        case 2:
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor, UIColor.black.cgColor]
        default:
            gradientLayer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        }
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }
}
