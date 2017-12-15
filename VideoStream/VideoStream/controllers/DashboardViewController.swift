//
//  DashboardViewController.swift
//  VideoStream
//
//  Created by macbook_user on 10/27/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var ref: DatabaseReference!
    
    var dashboardOptionsList:[String] = ["Meme","Video","Music","TreasuredMoments","Game","Text","Food","Shop","Helpline","Account"]
    
    override func viewDidLoad() {
        //let fb = FirebaseHelpers()
        //fb.fbSelect(tableName: "videos", selectColumnNames: ["v_url"], columnNames: [], parameters: [], isAnd: false)
        
        //ref = Database.database().reference()
        /*let tableRef = ref.child("videos")
        
        tableRef.observeSingleEvent(of : .value, with: { snapshot in
            if snapshot.hasChildren() {
                print("Snapshot has \(snapshot.childrenCount) children")
                
                let records : [DataSnapshot] = snapshot.children.allObjects as! [DataSnapshot]
                for record in records {
                    print("Record = \(record)")
                    let recordVal : Dictionary<String, String> = record.value as! Dictionary<String, String>
                    self.dashboardOptionsList.append(recordVal["v_name"]! + "!#@#!" + recordVal["v_url"]!)
                }
                
                /*let enumerator = snapshot.children
                 while let record = enumerator.nextObject() as? DataSnapshot {
                 let recordValue = record.value as! Dictionary
                 //print(rest.value!["v_url"])
                 }*/
            }
            
            print("Final Result = \(self.dashboardOptionsList)")
            
            //print("Final Result inside viewDidLoad = \(FirebaseHelpers.finalResult)")*/
            //let canvas = self.view!
            let canvas = self.scrollView!
            let vidW : CGFloat = canvas.bounds.maxX * 0.45
            let vidH : CGFloat = vidW / 16 * 10
            let vidEvenX : CGFloat = canvas.bounds.maxX * 0.03
            let vidOddX : CGFloat = canvas.bounds.maxX - vidEvenX - vidW
            print("Video Width = \(vidW) and Height = \(vidH)")
            var vidY = canvas.bounds.maxY * 0.03
            self.scrollView.contentSize = CGSize.init(width: self.view.bounds.maxX, height: vidY + ((vidH + vidEvenX) * CGFloat((self.dashboardOptionsList.count +  1
                )/2)))
            var count : Int = 0
            for dashboardOption in self.dashboardOptionsList {
                //print("Name = \(dashboardOption.components(separatedBy: "!#@#!")[0])")
                //print("URL = \(dashboardOption.components(separatedBy: "!#@#!")[1])")
                /*guard let videoUrl = URL(string: dashboardOption.components(separatedBy: "!#@#!")[1]) else {
                    return
                }*/
                //let imgGenerator = AVAssetImageGenerator(asset: AVURLAsset(url: videoUrl))
                //do {
                //    let cgImage = try imgGenerator.copyCGImage(at: CMTime.init(seconds: 1.0, preferredTimescale: CMTimeScale.init(1.0)), actualTime: nil)
                    
                   // let uiImage = UIImage(cgImage: cgImage)
                    
                    let dashboardThumbnail = UIImageView()
                
                    let dashboardThumbnailImage : UIImage? = UIImage(named: dashboardOption)
                
                    if(dashboardThumbnailImage == nil) {
                        dashboardThumbnail.image = UIImage(named: "wip1")
                    } else {
                        dashboardThumbnail.image = dashboardThumbnailImage
                    }
                
                    dashboardThumbnail.backgroundColor = UIColor.black
                    dashboardThumbnail.contentMode = UIViewContentMode.scaleAspectFit
                    dashboardThumbnail.isHidden = false
                    dashboardThumbnail.isOpaque = true
                    
                    let mediaLink = UIButton()
                    //playButton.setTitle(dashboardOption.components(separatedBy: "!#@#!")[1], for: UIControlState.selected)
                    mediaLink.setTitle(dashboardOption, for: UIControlState.selected)
                    mediaLink.alpha = 0.1
                    mediaLink.backgroundColor = UIColor.white
                    mediaLink.addTarget(self, action: #selector(self.displayDashboard), for: .touchDown)
                    
                    if(count % 2 == 0) {
                        dashboardThumbnail.frame = CGRect.init(x: vidEvenX, y: vidY, width: vidW, height: vidH)
                        mediaLink.frame = CGRect.init(x: vidEvenX, y: vidY, width: vidW, height: vidH)
                    } else {
                        dashboardThumbnail.frame = CGRect.init(x: vidOddX, y: vidY, width: vidW, height: vidH)
                        mediaLink.frame = CGRect.init(x: vidOddX, y: vidY, width: vidW, height: vidH)
                        vidY = vidY + vidH + vidEvenX
                    }
                    
                    canvas.addSubview(dashboardThumbnail)
                    canvas.addSubview(mediaLink)
                    count = count + 1
                //} catch {
                //    print(error)
                //}
            }
        //})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
        print("viewWillDisappear")
    }
    
    @objc func displayDashboard(sender:UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: sender.title(for: UIControlState.selected)! + "_Controller") as UIViewController
        
        if(sender.title(for: UIControlState.selected)! == "Music") {
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "dashToMusic", sender: self)
            }
        } else {
            
            
            //let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: vc.view.bounds.maxX, height: 100))
            let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: vc.view.bounds.maxX, height: 50))
            let navItem = UINavigationItem(title: sender.title(for: UIControlState.selected)!);
            //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
            //navItem.rightBarButtonItem = doneItem;
            
            
            
            let backbutton = UIButton(type: .custom)
            backbutton.setImage(UIImage(named: "BackButton.png"), for: UIControlState.normal)
            backbutton.setTitle("Back", for: UIControlState.normal)
            backbutton.setTitleColor(backbutton.tintColor, for: UIControlState.normal)
            backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
            
            //vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
            
            navItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton);
            
            navBar.setItems([navItem], animated: false);
            vc.view.addSubview(navBar);
            vc.view.isUserInteractionEnabled = true
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func backAction() -> Void {
        print("Back Action called")
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
