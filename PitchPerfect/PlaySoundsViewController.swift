//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Udumala, Mary on 11/11/16.
//  Copyright © 2016 Udumala, Mary. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: NSURL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBOutlet var slowPlaybackButton: UIButton!
    @IBOutlet var fastPlaybackButton: UIButton!
    @IBOutlet var chipmunkButton: UIButton!
    @IBOutlet var darthvadorPlaybackButton: UIButton!
    @IBOutlet var reverbButton: UIButton!
    @IBOutlet var echoButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    
    
    @IBAction func playSoundForButton(sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopSoundButton(sender: UIButton){
        stopAudio()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
