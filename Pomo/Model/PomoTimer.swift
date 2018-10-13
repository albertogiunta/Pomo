//
//  PomoTimer.swift
//  Pomo
//
//  Created by Alberto Giunta on 08/10/2018.
//  Copyright © 2018 Alberto Giunta. All rights reserved.
//

import Foundation

@objcMembers
class PomoTimer: NSObject {
    
    let workIntervalSeconds = 5 // 1500
    let pauseIntervalSeconds = 3 // 300
    let workIntervalColor = 0
    let pauseIntervalColor = 0
    
    var timer = Timer()
    var intervalTypeChangeListener: IntervalTypeChangeListener? = nil
    // TODO make enum work pause interval
    var isWorkInterval = true {
        didSet {
            intervalTypeChangeListener?.onIntervalTypeChanged(isWorkInterval: isWorkInterval)
        }
    }
    
    var playPauseChangeListener: PlayPauseChangeListener? = nil
    // TODO make enum pause run state
    var isPaused = true {
        didSet {
            playPauseChangeListener?.onPlayPauseStateChanged(isPaused: isPaused)
        }
    }
    
    dynamic lazy var timerValue: String = getRemainingTimeAsString()
    
    var remainingTime: Int = 0 {
        didSet {
            timerValue = getRemainingTimeAsString()
        }
    }
    
    override init() {
        super.init()
        resetTimerForCurrentIntervalType()
    }
    
    func playPause() {
        isPaused.toggle()
        stopTimer()
        if !isPaused {
            startTimer()
        }
    }
    
    func skip() {
        isWorkInterval.toggle()
        resetTimerForCurrentIntervalType()
        stopTimer()
        isPaused = false
        startTimer() // re-start after skip
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.remainingTime -= 1 // 1 second
            if self.remainingTime <= 0 {
                self.skip()
            }
        })
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    private func resetTimerForCurrentIntervalType() {
        if isWorkInterval {
            remainingTime = workIntervalSeconds
        } else {
            remainingTime = pauseIntervalSeconds
        }
    }
    
    private func getRemainingTimeAsString() -> String {
        let minutes = (remainingTime / 60) % 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
