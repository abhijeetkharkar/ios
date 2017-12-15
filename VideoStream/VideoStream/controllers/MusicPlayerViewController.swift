//
//  MusicPlayerViewController.swift
//  VideoStream
//
//  Created by macbook_user on 11/10/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    var player:AVAudioPlayer!
    override func viewDidLoad() {
        
        print("AVAudioSession Category Playback OK")
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            print("AVAudioSession is Active")
        } catch let error {
            print(error.localizedDescription)
        }
        let link = "https://ia601409.us.archive.org/20/items/UsaNationalAnthemFromSilo/silosinging-us-anthem_64kb.mp3"
        if let linkUrl = NSURL(string: link) {
            print(linkUrl)
            URLSession.shared.dataTask(with: linkUrl as URL, completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async() {
                    print("Finished downloading")
                    // you can use the data! here
                    if let data = data {
                        var error:NSError?
                        do {
                            
                            self.player = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
                            if let error = error {
                                print(error.description)
                            } else {
                                self.player.prepareToPlay()
                                self.player.play()
                            } 
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                        // there is data. do this
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }).resume()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
