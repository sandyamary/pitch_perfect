//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Udumala, Mary on 11/9/16.
//  Copyright © 2016 Udumala, Mary. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var tapToRecordLabel: UILabel!
    
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func recordAudio(_ sender: AnyObject) {
        configureUI(recording: true)
        
        //code for recording audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedAudio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: AnyObject) {
        configureUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func configureUI(recording: Bool){
        // Set label
        tapToRecordLabel.text =
            recording ? "Recording in progress" : "Tap to Record"
        
        // Set buttons
        recordButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopRecordingButton.isEnabled = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving the recording")
        if (flag) {
            performSegue(withIdentifier: "doneRecording", sender: audioRecorder.url)   }
        else {
            print("saving of the recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "doneRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

