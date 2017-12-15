//
//  MusicViewController.swift
//  VideoStream
//
//  Created by macbook_user on 10/25/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseDatabase

class MusicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AVAudioPlayerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genres: UIPickerView!
    
    var ref: DatabaseReference!
    var player: AVAudioPlayer!
    
    var musicList:[String] = []
    var relaxList:[String] = []
    var metalList:[String] = []
    var popList:[String] = []
    
    var selectedGenre:String = ""
    
    let pickerData:[String]=["relax","metal","pop_instrumental"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected Row = " + String(row))
    }
    
    override func viewDidLoad() {
        
        self.playSound(url: URL(string : "http://www.sample-videos.com/audio/mp3/crowd-cheering.mp3")!)
    }
    
    @objc func playSound(url : URL) {
        //guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }
        print("Inside playSound")
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            print("URL = \(url)")
            print("1")
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            //guard let player = player else { return }
            
            print("2")
            
            player.play()
            
        } catch let error {
            print("Inside Catch")
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
        print("viewWillDisappear")
    }
}
