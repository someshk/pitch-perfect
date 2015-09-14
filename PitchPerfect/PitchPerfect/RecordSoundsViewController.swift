//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/9/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordingLabel.text = "Tap to record"
        recordingLabel.hidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        println("in recordAudio: show the recording label");
        recordingLabel.text = "Recording"
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        // TODO: - Record user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
//        var currentDateTime = NSDate()
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyyy-HHmmss"
//        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        var recordingName = "my_audio.wav"
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
    successfully flag: Bool){
    
        println("audioRecorderDidFinishRecording")
        if flag {
            println("Successfuly stopped audio recording")
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        println("in stopRecording")
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
        
        audioRecorder.stop()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}