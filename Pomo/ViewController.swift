//
//  ViewController.swift
//  Pomo
//
//  Created by Alberto Giunta on 01/10/2018.
//  Copyright © 2018 Alberto Giunta. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
//    1500 - 300
    let workIntervalSeconds = 5
    let pauseIntervalSeconds = 3
    let oneSecond = 1
    
    var timer = Timer()
    var remainingTime = 0
    var isWorkInterval = false
    var isPaused = false
    
    @IBOutlet weak var lblTime: NSTextField!
    @IBOutlet weak var btnPlayPause: NSButton!
    
    
    @IBAction func onApplicationCloserSwitchClicked(_ sender: NSButton) {
        
    }
    
    
    @IBAction func onSocialsBlockerSwitchClicked(_ sender: NSButton) {
    }
    
    @IBAction func onPlayPauseClicked(_ sender: Any) {
        onPlayPauseClicked()
    }
    
    @IBAction func onSkipClicked(_ sender: Any) {
        onSkipButtonClicked()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetWorkTimer()
        updateRemainingTimeLabel()
        startWorkTimer()
    }
    
    override var representedObject: Any? {
        didSet {}
    }
    
    func onPlayPauseClicked() {
        isPaused.toggle()
        
        if isPaused {
            timer.invalidate()
            btnPlayPause.title = "▸"
        } else {
            startTimer()
            btnPlayPause.title = "॥"
        }
    }
    
    func onSkipButtonClicked() {
        isWorkInterval.toggle()
        
        if isWorkInterval {
            startWorkTimer()
        } else {
            startPauseTimer()
        }
        
        updateRemainingTimeLabel()
    }
    
    func startWorkTimer() {
        resetWorkTimer()
        startTimer()
        lblTime.textColor = NSColor.red
    }
    
    func startPauseTimer() {
        resetPauseTimer()
        startTimer()
        lblTime.textColor = NSColor.green
    }
    
    func resetWorkTimer() {
        remainingTime = workIntervalSeconds
        timer.invalidate()
    }
    
    func resetPauseTimer() {
        remainingTime = pauseIntervalSeconds
        timer.invalidate()
    }
    
    func updateRemainingTimeLabel() {
        self.lblTime.stringValue = self.getRemainingTimeAsString()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.remainingTime -= self.oneSecond
            self.updateRemainingTimeLabel()
            
            if self.remainingTime <= 0 {
                self.onSkipButtonClicked()
            }
        })
    }
    
    func getRemainingTimeAsString() -> String {
        let minutes = (remainingTime / 60) % 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

