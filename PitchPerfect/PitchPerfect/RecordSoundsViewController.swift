//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/9/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        // TODO: - Record user's voice
        println("in recordAudio: show the recording label");
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    }
}