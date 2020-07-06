//
//  AppDelegate.swift
//  Continuity-Helper
//
//  Created by LiangYi on 2020/7/5.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    
    let window = NSWindow()
    let wrapper = WrapperController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button, let image = NSImage(named: .init("StatusBarButton")) {
            button.image = image
            button.target = self
            button.action = #selector(onStatusItemClick)
        }
        // Window
        window.contentViewController = wrapper
        
        window.canHide = true
        window.hidesOnDeactivate = true

    }
    
    func getActiveScreen() -> NSScreen? {
        let mouse = NSEvent.mouseLocation
        
        return NSScreen.screens.first { NSMouseInRect(mouse, $0.frame, false) }
    }
    
    @objc func onStatusItemClick() {
        guard let event = NSApplication.shared.currentEvent else { return }
        
        let menu = NSMenu(title: "Continuity")
        self.setupMenu(menu)
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.window.center()
            self.window.makeKeyAndOrderFront(nil)
            self.window.makeFirstResponder(self.wrapper)
            NSMenu.popUpContextMenu(menu, with: event, for: self.wrapper.view)
        }
    }
    
    func setupMenu(_ menu: NSMenu) {
        // Check Option Key
        if NSEvent.modifierFlags == .option {
            let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q")
            quitItem.identifier = NSMenuItem.importFromDeviceIdentifier
            menu.addItem(quitItem)
        }
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(self)
    }

}

