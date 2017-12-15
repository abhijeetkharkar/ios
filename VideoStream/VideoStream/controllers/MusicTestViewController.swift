//
//  MusicTestViewController.swift
//  VideoStream
//
//  Created by macbook_user on 11/14/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class MusicTestViewController: UIViewController {
    
    //Class variables
    var ref: DatabaseReference!
    var musicList:[String] = []
    var allList:[String] = []
    var relaxList:[String] = []
    var metalList:[String] = []
    var popList:[String] = []
    var selectedGenre:String = "All"
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        let tableRef = ref.child("music")
        
        musicList = []
        allList = []
        relaxList = []
        metalList = []
        popList = []
        
        tableRef.observeSingleEvent(of : .value, with: { snapshot in
            if snapshot.hasChildren() {
                print("Snapshot has \(snapshot.childrenCount) children")
                
                let records : [DataSnapshot] = snapshot.children.allObjects as! [DataSnapshot]
                for record in records {
                    print("Record = \(record)")
                    let recordVal : Dictionary<String, String> = record.value as! Dictionary<String, String>
                    if(recordVal["m_category"] == "relax") {
                        self.relaxList.append(recordVal["m_name"]! + "!#@#!" + recordVal["m_url"]!)
                    } else if(recordVal["m_category"] == "metal") {
                        self.metalList.append(recordVal["m_name"]! + "!#@#!" + recordVal["m_url"]!)
                    } else {
                        self.popList.append(recordVal["m_name"]! + "!#@#!" + recordVal["m_url"]!)
                    }
                    self.allList.append(recordVal["m_name"]! + "!#@#!" + recordVal["m_url"]!)
                }
            }
            
            
            switch (self.selectedGenre) {
            case "Relax":
                self.musicList = self.relaxList
                break;
            case "Metal":
                self.musicList = self.metalList
                break;
            case "Pop":
                self.musicList = self.popList
                break;
            default:
                self.musicList = self.allList
                break;
            }
            
            //ALL THE OUTLETS --> Buttons and Labels - placing on the screen
            print("Relax Result = \(self.relaxList)")
            print("Metal Result = \(self.metalList)")
            print("Pop Result = \(self.popList)")
            print("Final Result = \(self.musicList)")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
