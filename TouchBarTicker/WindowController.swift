//
//  WindowController.swift
//  TouchBarTicker
//
//  Created by BrottyS on 22/08/2018.
//  Copyright © 2018 BrottyS. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let touchBar = NSTouchBar.CustomizationIdentifier("studio.leonov.TouchBarTicker.touchBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let custom = NSTouchBarItem.Identifier("studio.leonov.TouchBarTicker.TouchBarItem.custom")
}

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}

extension WindowController: NSTouchBarDelegate {
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.custom]
        touchBar.customizationAllowedItemIdentifiers = [.custom]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        
        switch identifier {
        case .custom:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            
            let canvasView = NSView()
            canvasView.wantsLayer = true
            canvasView.layer?.backgroundColor = NSColor.black.cgColor
            custom.view = canvasView
            
            let label = NSTextField()
            label.wantsLayer = true
            label.frame = CGRect(origin: CGPoint(x: 1000, y: 0), size: .zero)
            label.stringValue = "EVERYTHING IS GONNA BE OK 😊"
            let font = NSFont(name: "LCD Phone", size: 30)
            label.font = font
            label.textColor = .green
            label.backgroundColor = .clear
            label.isEditable = false
            label.sizeToFit()
            label.frame.origin.y -= 5
            canvasView.addSubview(label)
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = [label.frame.origin.x, label.frame.origin.y]
            animation.toValue = [-label.frame.width, label.frame.origin.y]
            animation.duration = 10.0
            animation.autoreverses = false
            animation.repeatCount = .infinity
            label.layer?.add(animation, forKey: "animatePosition")
            
            return custom
        default:
            return nil
        }
    }
    
}
