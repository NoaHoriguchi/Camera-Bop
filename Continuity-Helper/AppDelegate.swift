//
//  AppDelegate.swift
//  Continuity-Helper
//
//  Created by LiangYi on 2020/7/5.
//

import Cocoa
import Preferences

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: -AppDelegate
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NotificationManager.shared.initialize()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        // Do some cleaning
        ContinuityReceiver.shared.clear()
    }

}


