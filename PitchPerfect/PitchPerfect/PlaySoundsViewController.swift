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
        playAudioWithVariableRate(0.5)
    }
    
    
    @IBAction func fastPlayback(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    
    @IBAction func chipmunkPlayback(sender: UIButton) {
        println("in chipmunkPlayback")
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func darthVaderPlayback(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariableRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
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
}
