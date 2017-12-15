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
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
        case 2:
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor, UIColor.black.cgColor]
        case 3:
            gradientLayer.colors = [UIColor.init(red: 1, green: 51/255, blue: 100/255, alpha: 1).cgColor, UIColor.white.cgColor, UIColor.init(red: 1, green: 51/255, blue: 100/255, alpha: 1).cgColor]
        case 4:
            gradientLayer.colors = [UIColor.init(red: 204/255, green: 0, blue: 0, alpha: 1).cgColor, UIColor.init(red: 1, green: 51/255, blue: 51/255, alpha: 1).cgColor, UIColor.init(red: 1, green: 153/255, blue: 153/255, alpha: 1).cgColor, UIColor.init(red: 1, green: 51/255, blue: 51/255, alpha: 1).cgColor, UIColor.init(red: 204/255, green: 0, blue: 0, alpha: 1).cgColor]
        case 5:
            gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.orange.cgColor]
        case 6:
            gradientLayer.colors = [UIColor.init(red: 230/255, green: 92/255, blue: 0, alpha: 1).cgColor, UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.orange.cgColor, UIColor.init(red: 230/255, green: 92/255, blue: 0, alpha: 1).cgColor]
        default:
            gradientLayer.colors = [UIColor.init(red: 1, green: 51/255, blue: 100/255, alpha: 1).cgColor, UIColor.white.cgColor, UIColor.init(red: 1, green: 51/255, blue: 100/255, alpha: 1).cgColor]
        }
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }
}
