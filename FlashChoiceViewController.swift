//
//  FlashChoiceViewController.swift
//  AVCam Swift
//
//  Created by Steven Traversi on 8/5/17.
//  Copyright © 2017 Steven Traversi. All rights reserved.
//

import UIKit
import AVFoundation
import Cartography

class FlashChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black

        // Add and position each button
        autoButton = UIButton()
        autoButton.setTitle("Auto", for: .normal)
        autoButton.addTarget(self, action: #selector(setAuto), for: .touchUpInside)
        self.view.addSubview(autoButton)
        constrain(autoButton, self.view) { button, superview in
            button.height == superview.height
            button.width == 40.0
            button.top == superview.top
            button.left == superview.left
        }
        
        onButton = UIButton()
        onButton.setTitle("On", for: .normal)
        onButton.addTarget(self, action: #selector(setOn), for: .touchUpInside)
        self.view.addSubview(onButton)
        constrain(onButton, autoButton, self.view) { button, leftButton, superview in
            button.height == superview.height
            button.width == 40.0
            button.top == superview.top
            button.left == leftButton.right + 10.0
        }
        
        offButton = UIButton()
        offButton.setTitle("Off", for: .normal)
        offButton.addTarget(self, action: #selector(setOff), for: .touchUpInside)
        self.view.addSubview(offButton)
        constrain(offButton, onButton, self.view) { button, leftButton, superview in
            button.height == superview.height
            button.width == 40.0
            button.top == superview.top
            button.left == leftButton.right + 10.0
        }
        
    }
    
    // Flash state
        
    private dynamic func setAuto() { state = .auto; flashStateDidChange(state) }
    
    private dynamic func setOn() { state = .on; flashStateDidChange(state) }

    private dynamic func setOff() { state = .off; flashStateDidChange(state) }
    
    // UI elements
    
    var state: AVCaptureFlashMode = .off
    
    var autoButton: UIButton!

    var onButton: UIButton!
    
    var offButton: UIButton!
    
    // Set this callback
    
    public var flashStateDidChange: ((AVCaptureFlashMode) -> ())!
    
}
