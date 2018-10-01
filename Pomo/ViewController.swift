//
//  ViewController.swift
//  Pomo
//
//  Created by Alberto Giunta on 01/10/2018.
//  Copyright © 2018 Alberto Giunta. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let workIntervalSeconds = 1500
    let pauseIntervalSeconds = 300
    let oneSecond = 1
    
    var intervalCounter = 0
    var timer = Timer()
    var isWorkInterval = false
    
    @IBOutlet weak var lblCountdown: NSTextField!
    
    @IBOutlet weak var btnStartStop: NSButton!
    
    @IBAction func onStartStopButtonClicked(_ sender: Any) {
        isWorkInterval.toggle()
        
        if isWorkInterval {
            btnStartStop.title = "Start your 5 minutes pause now"
            startWorkTimer()
        } else {
            btnStartStop.title = "Back to work!"
            startPauseTimer()
        }
        
        updateRemainingTimeLabel()
    }
    
    func startWorkTimer() {
        resetWorkTimer()
        startTimer()
    }
    
    func resetWorkTimer() {
        intervalCounter = workIntervalSeconds
        timer.invalidate()
    }
    
    func startPauseTimer() {
        resetPauseTimer()
        startTimer()
    }
    
    func resetPauseTimer() {
        intervalCounter = pauseIntervalSeconds
        timer.invalidate()
    }
    
    func getRemainingTimeAsString() -> String{
        let minutes = (intervalCounter / 60) % 60
        let seconds = intervalCounter % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateRemainingTimeLabel() {
        self.lblCountdown.stringValue = self.getRemainingTimeAsString()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.intervalCounter -= self.oneSecond
            self.updateRemainingTimeLabel()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetWorkTimer()
        self.btnStartStop.title = "POMO! NOW!"
        self.lblCountdown.stringValue = "25:00"
    }

    override var representedObject: Any? {
        didSet {}
    }
}

