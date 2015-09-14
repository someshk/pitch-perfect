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

    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    var error:NSError?
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the path of the Music file
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote",  ofType: "mp3") {
//            var fileUrl = NSURL.fileURLWithPath(filePath)
//            // Init audio player
//            audioPlayer = AVAudioPlayer( contentsOfURL: fileUrl, error: nil)
//            audioPlayer.enableRate = true
//        } else {
//            println("file not found")
//        }
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer( contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func slowPlayback(sender: UIButton) {
        println("in slowPlayback")
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    
    @IBAction func fastPlayback(sender: UIButton) {
        println("in fastPlayback")
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }
    
    
    @IBAction func chipmunkPlayback(sender: UIButton) {
        println("in chipmunkPlayback")
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func darthVaderPlayback(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        println("in playAudioWithVariablePitch")
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        
        timePitch.pitch = pitch
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        
        audioEngine.connect(timePitch,  to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(&error)
        pitchPlayer.play()
    }
    
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
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
