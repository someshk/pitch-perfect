//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/9/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordAudio(sender: UIButton) {
        // TODO: - Record user's voice
        println("in recordAudio: show the recording label");
        if recordingLabel.hidden==true {
            recordingLabel.hidden = false
        } else {
            recordingLabel.hidden = true
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
    }
}