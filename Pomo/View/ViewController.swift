//
//  ViewController.swift
//  Pomo
//
//  Created by Alberto Giunta on 01/10/2018.
//  Copyright © 2018 Alberto Giunta. All rights reserved.
//

import Cocoa

@objcMembers
class ViewController: NSViewController, IntervalTypeChangeListener, PlayPauseChangeListener {
    
//    btnExpandBlockersSection
//    btnExpandTodoSection
    
//    chbApplicationQuitter
//    chbWebsiteBlocker
    
    @IBOutlet weak var lblTime: NSTextField!
    @IBOutlet weak var btnPlayPause: NSButton!
    @IBOutlet weak var btnSkip: NSButton!
    
    lazy var pomoTimer = PomoTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pomoTimer.intervalTypeChangeListener = self
        pomoTimer.playPauseChangeListener = self
    }
    
    override var representedObject: Any? {
        didSet {}
    }
    
    @IBAction func onBtnPlayPauseClicked(_ sender: Any) {
        pomoTimer.playPause()
    }
    
    @IBAction func onBtnSkipClicked(_ sender: Any) {
        pomoTimer.skip()
    }
    
    func onIntervalTypeChanged(isWorkInterval: Bool) {
        // TODO make static colors
        if isWorkInterval {
            lblTime.textColor = NSColor(red:0.92, green:0.34, blue:0.34, alpha:1.0)
        } else {
            lblTime.textColor = NSColor(red:0.44, green:0.81, blue:0.59, alpha:1.0)
        }
    }
    
    func onPlayPauseStateChanged(isPaused: Bool) {
        // TODO make static images
        if pomoTimer.isPaused {
            btnPlayPause.image = NSImage(named: "play")
        } else {
            btnPlayPause.image = NSImage(named: "pause")
        }
    }
}

@objc protocol IntervalTypeChangeListener {
    func onIntervalTypeChanged(isWorkInterval: Bool)
}

@objc protocol PlayPauseChangeListener {
    func onPlayPauseStateChanged(isPaused: Bool)
}
    
    
//    func checkChecks() {
//        if isWorkInterval {
//            if btnBlockAllSocials.state == .on {
//
//                let res = ShellHelper.run(launchPath: "/bin/ls", arguments: ["/Users/albertogiunta"])
//                print(res)
//            }
//
//            if btnCloseAllApplications.state == .on {
//                print("close all selected applications")
//            }
//
//        } else {
//            if btnBlockAllSocials.state == .on {
//                print("unblock socials now")
//            }
//
//            if btnCloseAllApplications.state == .on {
//                print("open all selected applications")
//            }
//        }
//    }


//class ShellHelper {
//    static func run(launchPath path: String, arguments args: [String]) -> String {
//        let task = Process()
//        let pipe = Pipe()
//        task.launchPath = path
//        task.arguments = args
//        task.standardOutput = pipe
//        task.standardError = pipe
//
//        task.launch()
//
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        let output = String(data: data, encoding: .utf8)
//        task.waitUntilExit()
//
//        return(output!)
//    }
//}
