//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/9/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import UIKit
import AVFoundation

final class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    let pauseRecordingIcon = UIImage(named: "pause")
    let resumeRecordingIcon = UIImage(named: "resume")
    
    var recordingButtonState = RecordingButtonState.Normal
    
    enum RecordingButtonState : Int {
        case Normal
        case Recording
        case Paused
        case Stopped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        changeUIState(RecordingButtonState.Normal);
        recordingButtonState = RecordingButtonState.Normal;
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        println("in recordAudio: show the recording label");
        changeUIState(RecordingButtonState.Recording);
        recordingButtonState = RecordingButtonState.Recording
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

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
    
    @IBAction func pauseResumeRecording(sender: UIButton) {
        if(recordingButtonState == RecordingButtonState.Recording) {
            // Pause the recording
            audioRecorder.pause();
            changeUIState(RecordingButtonState.Paused);
            recordingButtonState = RecordingButtonState.Paused
        } else if(recordingButtonState == RecordingButtonState.Paused) {
            // Reume the audio recording
            changeUIState(RecordingButtonState.Recording);
            recordingButtonState = RecordingButtonState.Recording
            audioRecorder.record()
        }
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){
        if flag {
            println("Recording completed successfully")
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            // Move to the next screen
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording wasnt successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        println("in stopRecording")
        audioRecorder.stop()
        changeUIState(RecordingButtonState.Stopped)
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    private func changeUIState(uiState: RecordingButtonState!) {
        if(uiState == RecordingButtonState.Normal) {
            stopButton.hidden = true;
            recordingLabel.text = "Tap to record"
            recordButton.enabled = true
            pauseResumeButton.hidden = true
            pauseResumeButton.setImage(pauseRecordingIcon, forState: UIControlState.Normal)
        } else if (uiState == RecordingButtonState.Paused) {
            pauseResumeButton.setImage(resumeRecordingIcon, forState: UIControlState.Normal)
            recordingLabel.text = "Recording paused"
        } else if (uiState == RecordingButtonState.Recording) {
            pauseResumeButton.setImage(pauseRecordingIcon, forState: UIControlState.Normal)
            recordingLabel.text = "Recording"
            stopButton.hidden = false
            pauseResumeButton.hidden = false
            recordButton.enabled = false
        } else if (uiState == RecordingButtonState.Stopped) {
            stopButton.hidden = true
            pauseResumeButton.hidden = true
            recordButton.enabled = true
            pauseResumeButton.setImage(pauseRecordingIcon, forState: UIControlState.Normal)
        }
    }
}