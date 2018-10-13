//
//  WindowController.swift
//  Pomo
//
//  Created by Alberto Giunta on 06/10/2018.
//  Copyright © 2018 Alberto Giunta. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window?.title = "Pomo"
        window?.styleMask.remove(.resizable)
        window?.titlebarAppearsTransparent = true
        window?.standardWindowButton(.closeButton)?.isHidden = false
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = false
        window?.standardWindowButton(.zoomButton)?.isHidden = true
    }

}
