//
//  Player.swift
//  hw4
//
//  Created by macbook_user on 9/24/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding {
    var srNo:Int! = 0
    var name:String = ""
    var email:String = ""
    var education:String = ""
    var major:String = ""
    var dob:Date = Date()
    var matchesPlayed:Int! = 0
    var averageScore:Double! = 0
    var highScore:Int! = 0
    var rpn:Double! = 0.0
    var isActive = false
    var activatedOn:String = ""
    
    // Memberwise initializer
    init(srNo: Int, name: String, email: String, education: String, major: String, dob : Date, matchesPlayed : Int, averageScore : Double, highScore : Int, rpn : Double, isActive : Bool, activatedOn : String) {
        self.srNo = srNo
        self.name = name
        self.email = email
        self.education = education
        self.major = major
        self.dob = dob
        self.matchesPlayed = matchesPlayed
        self.averageScore = averageScore
        self.highScore = highScore
        self.rpn = rpn
        self.isActive = isActive
        self.activatedOn = activatedOn
    }
    
    // MARK: NSCoding
    
    required init(coder decoder: NSCoder) {
        //print("SrNo decoded value = \(decoder.decodeObject(forKey: "srNo"))")
        srNo = decoder.decodeInteger(forKey: "srNo")
        //print("Name decoded value = \(decoder.decodeObject(forKey: "name"))")
        name = (decoder.decodeObject(forKey: "name") as? String)!
        email = (decoder.decodeObject(forKey: "email") as? String)!
        education = (decoder.decodeObject(forKey: "education") as? String)!
        major = (decoder.decodeObject(forKey: "major") as? String)!
        dob = (decoder.decodeObject(forKey: "dob") as? Date)!
        matchesPlayed = decoder.decodeInteger(forKey: "matchesPlayed")
        averageScore = decoder.decodeDouble(forKey: "averageScore")
        highScore = decoder.decodeInteger(forKey: "highScore")
        rpn = decoder.decodeDouble(forKey: "rpn")
        isActive = decoder.decodeBool(forKey: "isActive")
        activatedOn = (decoder.decodeObject(forKey: "activatedOn") as? String)!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.srNo!, forKey: "srNo")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.email, forKey: "email")
        coder.encode(self.education, forKey: "education")
        coder.encode(self.major, forKey: "major")
        coder.encode(self.dob, forKey: "dob")
        coder.encode(self.matchesPlayed!, forKey: "matchesPlayed")
        coder.encode(self.averageScore!, forKey: "averageScore")
        coder.encode(self.highScore!, forKey: "highScore")
        coder.encode(self.rpn!, forKey: "rpn")
        coder.encode(self.isActive, forKey: "isActive")
        coder.encode(self.activatedOn, forKey: "activatedOn")
    }
}
