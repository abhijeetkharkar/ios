//
//  ViewController.swift
//  ViewDrawingPractice
//
//  Created by macbook_user on 9/7/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var lips: MouthView!
    
    @IBOutlet weak var mustauche: MustacheView!
    
    @IBOutlet weak var hair: HairView!
    
    @IBOutlet weak var irisColor: UITextField!
    
    @IBOutlet weak var iris: IrisView!
    
    @IBOutlet weak var iris1: IrisView!
    
    @IBOutlet weak var glassView: GlassView!
    
    @IBOutlet weak var musSlider: UISlider! {
        didSet{
            musSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        }
    }
    
    @IBOutlet weak var glassSwitch: UISwitch! {
        didSet{
            glassSwitch.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hairPaint(_ sender: UISlider) {
        let value = sender.value
        //print("Slider Value = "+String(value))
        hair.setControlValue(val: Int(value))
    }
    
    
    @IBAction func glassesOnOff(_ sender: UISwitch) {
        /*let temp:[UIView]=self.view.subviews
        for view in temp {
            if(view.restorationIdentifier=="glassID") {
                
            }
        }*/
        if(sender.isOn) {
            glassView.isHidden = false
        } else {
            glassView.isHidden = true
        }
    }

    @IBAction func lipPout(_ sender: UISlider) {
        let value = sender.value
        //self.view.subviews
        //print("Slider Value = "+String(value))
        lips.setValue1(val: value)
    }
    
    @IBAction func twirlMustaucheGesture(_ sender: UIPanGestureRecognizer) {
        //let value:Float = 1.0
        //print ("Translation = \(sender.translation(in: mustauche)))")
        let value = sender.translation(in: mustauche).y
        var finalValue:Float = 1
        if(value<0) {
            if(value < -25) {
                finalValue = 0.75
            } else {
                finalValue = Float(1) - Float(value/100)
            }
        } else {
            if(value > 25) {
                finalValue = 1.25
            } else {
                finalValue = Float(1) + Float(value/100)
            }
        }
        mustauche.setControlValue(val: finalValue)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        irisColor.resignFirstResponder()
        return false
    }
    
    @IBAction func colorEntered(_ sender: UITextField) {
        let value = sender.text!.lowercased()
        print("Color is \(value)")
        iris.setColor(val: value)
        iris1.setColor(val: value)
        lips.setColor(val: value)
        sender.text=""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

