//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/10/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the path of the Music file
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote",  ofType: "mp3") {
            var fileUrl = NSURL.fileURLWithPath(filePath)
            // Init audio player
            audioPlayer = AVAudioPlayer( contentsOfURL: fileUrl, error: nil)
            audioPlayer.enableRate = true
        } else {
            println("file not found")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func slowPlayback(sender: UIButton) {
        println("in slowPlayback")
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}